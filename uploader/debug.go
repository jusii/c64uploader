// Remote debugging helpers for the native C64 client running on a real
// Ultimate device. Provides: screen RAM peek (renders the 40x25 text screen as
// ASCII), key injection via the $02A7 debug byte baked into c64client, and
// thin wrappers for reset/reboot/menu.
package main

import (
	"flag"
	"fmt"
	"log/slog"
	"os"
	"strings"
	"time"
)

const (
	screenAddr  = "0400"
	colorAddr   = "d800"
	screenBytes = 1000 // 40 * 25
	debugKeyHex = "02a7"
)

// screenCodeToASCII maps a C64 screen code (0..255) to a printable ASCII byte.
// Uppercase/graphics character set is assumed, which is what our native app
// uses. Reverse-video (high bit set) is flattened to the same base char.
func screenCodeToASCII(code byte) byte {
	c := code & 0x7f
	switch {
	case c == 0:
		return '@'
	case c >= 1 && c <= 26:
		return 'A' + (c - 1)
	case c == 27:
		return '['
	case c == 28:
		return '\\'
	case c == 29:
		return ']'
	case c == 30:
		return '^'
	case c == 31:
		return '_'
	case c >= 32 && c <= 63:
		return c
	}
	return '.'
}

// renderScreen formats 1000 bytes of screen RAM as a boxed 40x25 block.
func renderScreen(screen []byte) string {
	var b strings.Builder
	b.WriteString("+" + strings.Repeat("-", 40) + "+\n")
	for row := 0; row < 25; row++ {
		b.WriteByte('|')
		for col := 0; col < 40; col++ {
			b.WriteByte(screenCodeToASCII(screen[row*40+col]))
		}
		b.WriteString("|\n")
	}
	b.WriteString("+" + strings.Repeat("-", 40) + "+\n")
	return b.String()
}

// keyCodes maps a shorthand token to the PETSCII-ish semantic char our native
// client expects to come back from get_key(). These mirror the constants used
// inside c64client/src/main.c — see the page-specific switch statements there.
var keyCodes = map[string]byte{
	"up":    'u',
	"down":  'd',
	"next":  'n',
	"prev":  'p',
	"info":  'i',
	"enter": '\r',
	"ret":   '\r',
	"back":  8,
	"right": '>', // enter category / run entry (context-dependent)
	"tab":   '\t',
	"space": ' ',
	"q":     'q',
	"c":     'c', // settings from main menu
	"slash": '/',
}

// parseKey resolves a shorthand token or single character into an injected
// byte. Single-character tokens are passed through (uppercased so the client's
// get_key() comparisons match what it produces in search mode).
func parseKey(tok string) (byte, error) {
	tok = strings.TrimSpace(tok)
	if tok == "" {
		return 0, fmt.Errorf("empty key token")
	}
	if code, ok := keyCodes[strings.ToLower(tok)]; ok {
		return code, nil
	}
	if len(tok) == 1 {
		c := tok[0]
		if c >= 'a' && c <= 'z' {
			c -= 32
		}
		return c, nil
	}
	return 0, fmt.Errorf("unknown key %q (known: up down next prev info enter back right tab space q c slash, or a single char)", tok)
}

// injectKey writes a single key code into $02A7 and waits until the client
// clears it, so rapid sequential presses don't overwrite each other.
func injectKey(client *APIClient, code byte, timeout time.Duration) error {
	if err := client.WriteMemory(debugKeyHex, []byte{code}); err != nil {
		return fmt.Errorf("writing debug key: %w", err)
	}
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		buf, err := client.ReadMemory(debugKeyHex, 1)
		if err != nil {
			return fmt.Errorf("polling debug key: %w", err)
		}
		if len(buf) >= 1 && buf[0] == 0 {
			return nil
		}
		time.Sleep(20 * time.Millisecond)
	}
	return fmt.Errorf("timeout waiting for client to consume key 0x%02X", code)
}

func runDebug(args []string) {
	if len(args) == 0 {
		fmt.Fprintf(os.Stderr, "Usage: c64uploader debug <subcommand> [options]\n\n")
		fmt.Fprintf(os.Stderr, "Subcommands:\n")
		fmt.Fprintf(os.Stderr, "  screen                        Peek 40x25 text screen and render as ASCII\n")
		fmt.Fprintf(os.Stderr, "  press <key>[,<key>...]        Inject one or more keys (requires debug-built client)\n")
		fmt.Fprintf(os.Stderr, "  reset                         Soft reset the C64\n")
		fmt.Fprintf(os.Stderr, "  reboot                        Reboot the Ultimate firmware\n")
		fmt.Fprintf(os.Stderr, "  menu                          Press Ultimate menu button\n")
		fmt.Fprintf(os.Stderr, "  info                          Show device info\n\n")
		fmt.Fprintf(os.Stderr, "Key tokens: up down next prev info enter back right tab space q c slash,\n")
		fmt.Fprintf(os.Stderr, "or any single character (A-Z, 0-9 etc.). Example:\n")
		fmt.Fprintf(os.Stderr, "  c64uploader debug press down,down,right\n")
		os.Exit(1)
	}

	sub := args[0]
	fs := flag.NewFlagSet("debug "+sub, flag.ExitOnError)
	host := fs.String("host", "c64u", "C64 Ultimate hostname or IP address")
	verbose := fs.Bool("v", false, "Enable verbose debug logging")
	delay := fs.Duration("delay", 80*time.Millisecond, "Delay between keys (press only)")
	fs.Parse(args[1:])

	if *verbose {
		slog.SetLogLoggerLevel(slog.LevelDebug)
	}

	client := NewAPIClient(*host)

	switch sub {
	case "screen":
		data, err := client.ReadMemory(screenAddr, screenBytes)
		if err != nil {
			fmt.Fprintf(os.Stderr, "screen read failed: %v\n", err)
			os.Exit(1)
		}
		if len(data) != screenBytes {
			fmt.Fprintf(os.Stderr, "warning: got %d bytes, expected %d\n", len(data), screenBytes)
		}
		fmt.Print(renderScreen(data))
	case "press":
		if fs.NArg() < 1 {
			fmt.Fprintln(os.Stderr, "press: need at least one key")
			os.Exit(1)
		}
		raw := strings.Join(fs.Args(), ",")
		tokens := strings.Split(raw, ",")
		for i, tok := range tokens {
			code, err := parseKey(tok)
			if err != nil {
				fmt.Fprintf(os.Stderr, "press: %v\n", err)
				os.Exit(1)
			}
			if err := injectKey(client, code, 2*time.Second); err != nil {
				fmt.Fprintf(os.Stderr, "press %q: %v\n", tok, err)
				os.Exit(1)
			}
			fmt.Printf("pressed %q (0x%02X)\n", tok, code)
			if i < len(tokens)-1 {
				time.Sleep(*delay)
			}
		}
	case "reset":
		if err := client.resetMachine(); err != nil {
			fmt.Fprintf(os.Stderr, "reset failed: %v\n", err)
			os.Exit(1)
		}
		fmt.Println("reset OK")
	case "reboot":
		if err := client.Reboot(); err != nil {
			fmt.Fprintf(os.Stderr, "reboot failed: %v\n", err)
			os.Exit(1)
		}
		fmt.Println("reboot issued")
	case "menu":
		if err := client.MenuButton(); err != nil {
			fmt.Fprintf(os.Stderr, "menu failed: %v\n", err)
			os.Exit(1)
		}
		fmt.Println("menu button pressed")
	case "info":
		data, err := client.ReadMemory("0400", 1)
		if err != nil {
			fmt.Fprintf(os.Stderr, "device not reachable: %v\n", err)
			os.Exit(1)
		}
		fmt.Printf("device %s reachable, first screen byte = 0x%02X\n", *host, data[0])
	default:
		fmt.Fprintf(os.Stderr, "debug: unknown subcommand %q\n", sub)
		os.Exit(1)
	}
}
