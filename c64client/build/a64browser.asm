; Compiled with 1.32.266
--------------------------------------------------------------------
startup: ; startup
0801 : 0b __ __ INV
0802 : 08 __ __ PHP
0803 : 0a __ __ ASL
0804 : 00 __ __ BRK
0805 : 9e __ __ INV
0806 : 32 __ __ INV
0807 : 30 36 __ BMI $083f ; (startup + 62)
0809 : 31 00 __ AND ($00),y 
080b : 00 __ __ BRK
080c : 00 __ __ BRK
080d : ba __ __ TSX
080e : 8e 40 36 STX $3640 ; (spentry + 0)
0811 : a2 37 __ LDX #$37
0813 : a0 1c __ LDY #$1c
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 42 __ CPX #$42
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 a0 __ CPY #$a0
082c : d0 f9 __ BNE $0827 ; (startup + 38)
082e : a9 00 __ LDA #$00
0830 : a2 f7 __ LDX #$f7
0832 : d0 03 __ BNE $0837 ; (startup + 54)
0834 : 95 00 __ STA $00,x 
0836 : e8 __ __ INX
0837 : e0 f7 __ CPX #$f7
0839 : d0 f9 __ BNE $0834 ; (startup + 51)
083b : a9 7c __ LDA #$7c
083d : 85 23 __ STA SP + 0 
083f : a9 9f __ LDA #$9f
0841 : 85 24 __ STA SP + 1 
0843 : 20 80 08 JSR $0880 ; (main.s1 + 0)
0846 : a9 4c __ LDA #$4c
0848 : 85 54 __ STA $54 
084a : a9 00 __ LDA #$00
084c : 85 13 __ STA P6 
084e : a9 19 __ LDA #$19
0850 : 85 16 __ STA P9 
0852 : 60 __ __ RTS
--------------------------------------------------------------------
main: ; main()->i16
; 656, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
0880 : a2 05 __ LDX #$05
0882 : b5 53 __ LDA T0 + 0,x 
0884 : 9d 7e 9f STA $9f7e,x ; (main@stack + 0)
0887 : ca __ __ DEX
0888 : 10 f8 __ BPL $0882 ; (main.s1 + 2)
.s4:
088a : a9 00 __ LDA #$00
088c : 85 0d __ STA P0 
088e : 85 0e __ STA P1 
0890 : 8d 20 d0 STA $d020 
0893 : 8d 21 d0 STA $d021 
0896 : 20 2b 0f JSR $0f2b ; (clear_screen.s4 + 0)
0899 : a9 15 __ LDA #$15
089b : 85 0f __ STA P2 
089d : a9 10 __ LDA #$10
089f : 85 10 __ STA P3 
08a1 : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
08a4 : a9 02 __ LDA #$02
08a6 : 85 0e __ STA P1 
08a8 : a9 10 __ LDA #$10
08aa : 85 10 __ STA P3 
08ac : a9 28 __ LDA #$28
08ae : 85 0f __ STA P2 
08b0 : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
08b3 : a9 01 __ LDA #$01
08b5 : 8d 41 36 STA $3641 ; (uci_target + 0)
08b8 : 8d 85 9f STA $9f85 ; (cmd[0] + 1)
08bb : a9 02 __ LDA #$02
08bd : 85 0f __ STA P2 
08bf : a9 00 __ LDA #$00
08c1 : 85 10 __ STA P3 
08c3 : 8d 84 9f STA $9f84 ; (cmd[0] + 0)
08c6 : a9 84 __ LDA #$84
08c8 : 85 0d __ STA P0 
08ca : a9 9f __ LDA #$9f
08cc : 85 0e __ STA P1 
08ce : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
08d1 : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
08d4 : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
08d7 : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
08da : ad 00 3f LDA $3f00 ; (uci_status[0] + 0)
08dd : c9 30 __ CMP #$30
08df : d0 07 __ BNE $08e8 ; (main.s5 + 0)
.s6:
08e1 : ad 01 3f LDA $3f01 ; (uci_status[0] + 1)
08e4 : c9 30 __ CMP #$30
08e6 : f0 30 __ BEQ $0918 ; (main.s7 + 0)
.s5:
08e8 : a9 11 __ LDA #$11
08ea : 85 10 __ STA P3 
08ec : a9 91 __ LDA #$91
08ee : 85 0f __ STA P2 
08f0 : 20 e3 35 JSR $35e3 ; (print_at@proxy + 0)
08f3 : a9 06 __ LDA #$06
.s173:
08f5 : 85 0e __ STA P1 
08f7 : a9 a9 __ LDA #$a9
08f9 : 85 0f __ STA P2 
08fb : a9 11 __ LDA #$11
08fd : 85 10 __ STA P3 
08ff : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
0902 : 20 bf 11 JSR $11bf ; (wait_key.l5 + 0)
0905 : a9 01 __ LDA #$01
0907 : 85 1b __ STA ACCU + 0 
0909 : a9 00 __ LDA #$00
.s3:
090b : 85 1c __ STA ACCU + 1 
090d : a2 05 __ LDX #$05
090f : bd 7e 9f LDA $9f7e,x ; (main@stack + 0)
0912 : 95 53 __ STA T0 + 0,x 
0914 : ca __ __ DEX
0915 : 10 f8 __ BPL $090f ; (main.s3 + 4)
0917 : 60 __ __ RTS
.s7:
0918 : a9 12 __ LDA #$12
091a : 85 10 __ STA P3 
091c : a9 81 __ LDA #$81
091e : 85 0f __ STA P2 
0920 : 20 e3 35 JSR $35e3 ; (print_at@proxy + 0)
0923 : a9 06 __ LDA #$06
0925 : 85 0e __ STA P1 
0927 : a9 12 __ LDA #$12
0929 : 85 10 __ STA P3 
092b : a9 97 __ LDA #$97
092d : 85 0f __ STA P2 
092f : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
0932 : 20 ab 12 JSR $12ab ; (load_settings.s4 + 0)
0935 : a9 13 __ LDA #$13
0937 : 85 10 __ STA P3 
0939 : a9 08 __ LDA #$08
093b : 85 0e __ STA P1 
093d : a9 b2 __ LDA #$b2
093f : 85 0f __ STA P2 
0941 : 20 dc 35 JSR $35dc ; (print_at@proxy + 0)
0944 : a9 36 __ LDA #$36
0946 : 85 10 __ STA P3 
0948 : a9 42 __ LDA #$42
094a : 85 0f __ STA P2 
094c : 20 01 36 JSR $3601 ; (print_at@proxy + 0)
094f : a9 13 __ LDA #$13
0951 : 85 10 __ STA P3 
0953 : a9 0a __ LDA #$0a
0955 : 85 0e __ STA P1 
0957 : a9 bb __ LDA #$bb
0959 : 85 0f __ STA P2 
095b : 20 dc 35 JSR $35dc ; (print_at@proxy + 0)
095e : 20 d1 13 JSR $13d1 ; (uci_getipaddress.s4 + 0)
0961 : ad 00 3f LDA $3f00 ; (uci_status[0] + 0)
0964 : c9 30 __ CMP #$30
0966 : d0 25 __ BNE $098d ; (main.s8 + 0)
.s168:
0968 : ad 01 3f LDA $3f01 ; (uci_status[0] + 1)
096b : c9 30 __ CMP #$30
096d : d0 1e __ BNE $098d ; (main.s8 + 0)
.s169:
096f : a9 14 __ LDA #$14
0971 : 85 10 __ STA P3 
0973 : a9 0c __ LDA #$0c
0975 : 85 0e __ STA P1 
0977 : a9 06 __ LDA #$06
0979 : 85 0f __ STA P2 
097b : 20 dc 35 JSR $35dc ; (print_at@proxy + 0)
097e : a9 04 __ LDA #$04
0980 : 85 0d __ STA P0 
0982 : a9 37 __ LDA #$37
0984 : 85 10 __ STA P3 
0986 : a9 1c __ LDA #$1c
0988 : 85 0f __ STA P2 
098a : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
.s8:
098d : a9 14 __ LDA #$14
098f : 85 10 __ STA P3 
0991 : a9 0e __ LDA #$0e
0993 : 85 0e __ STA P1 
0995 : a9 0b __ LDA #$0b
0997 : 85 0f __ STA P2 
0999 : 20 dc 35 JSR $35dc ; (print_at@proxy + 0)
099c : 20 d0 11 JSR $11d0 ; (keyb_poll.s4 + 0)
099f : 2c f9 36 BIT $36f9 ; (keyb_key + 0)
09a2 : 10 08 __ BPL $09ac ; (main.l9 + 0)
.l167:
09a4 : 20 d0 11 JSR $11d0 ; (keyb_poll.s4 + 0)
09a7 : 2c f9 36 BIT $36f9 ; (keyb_key + 0)
09aa : 30 f8 __ BMI $09a4 ; (main.l167 + 0)
.l9:
09ac : 20 d0 11 JSR $11d0 ; (keyb_poll.s4 + 0)
09af : ad f9 36 LDA $36f9 ; (keyb_key + 0)
09b2 : 10 f8 __ BPL $09ac ; (main.l9 + 0)
.s10:
09b4 : 29 3f __ AND #$3f
09b6 : c9 14 __ CMP #$14
09b8 : d0 26 __ BNE $09e0 ; (main.s11 + 0)
.s129:
09ba : a9 00 __ LDA #$00
09bc : 8d 66 36 STA $3666 ; (settings_editing + 0)
09bf : 8d 64 36 STA $3664 ; (settings_cursor + 0)
09c2 : 8d 65 36 STA $3665 ; (settings_cursor + 1)
09c5 : 8d 63 36 STA $3663 ; (current_page + 1)
09c8 : a9 03 __ LDA #$03
09ca : 8d 62 36 STA $3662 ; (current_page + 0)
09cd : 20 79 13 JSR $1379 ; (strlen@proxy + 0)
09d0 : a5 1b __ LDA ACCU + 0 
09d2 : 8d 67 36 STA $3667 ; (settings_edit_pos + 0)
09d5 : a5 1c __ LDA ACCU + 1 
09d7 : 8d 68 36 STA $3668 ; (settings_edit_pos + 1)
09da : 20 2b 14 JSR $142b ; (draw_settings.s4 + 0)
09dd : 4c 08 0e JMP $0e08 ; (main.l130 + 0)
.s11:
09e0 : 20 34 23 JSR $2334 ; (connect_to_server.s4 + 0)
09e3 : a5 1b __ LDA ACCU + 0 
09e5 : d0 07 __ BNE $09ee ; (main.l172 + 0)
.s12:
09e7 : 85 0d __ STA P0 
09e9 : a9 0c __ LDA #$0c
09eb : 4c f5 08 JMP $08f5 ; (main.s173 + 0)
.l172:
09ee : 20 21 25 JSR $2521 ; (load_categories.s4 + 0)
.l171:
09f1 : a9 2a __ LDA #$2a
09f3 : a2 00 __ LDX #$00
.l170:
09f5 : 86 53 __ STX T0 + 0 
09f7 : 85 54 __ STA T0 + 1 
.l13:
09f9 : a5 53 __ LDA T0 + 0 
09fb : 8d fe 9f STA $9ffe ; (sstack + 8)
09fe : a5 54 __ LDA T0 + 1 
.l14:
0a00 : 8d ff 9f STA $9fff ; (sstack + 9)
0a03 : 20 12 28 JSR $2812 ; (draw_list.s1 + 0)
.l15:
0a06 : 20 f6 15 JSR $15f6 ; (get_key.s1 + 0)
0a09 : a5 1b __ LDA ACCU + 0 
0a0b : f0 f9 __ BEQ $0a06 ; (main.l15 + 0)
.s16:
0a0d : ad 63 36 LDA $3663 ; (current_page + 1)
0a10 : 85 56 __ STA T1 + 1 
0a12 : d0 0a __ BNE $0a1e ; (main.s17 + 0)
.s19:
0a14 : ac 62 36 LDY $3662 ; (current_page + 0)
0a17 : c0 01 __ CPY #$01
0a19 : d0 03 __ BNE $0a1e ; (main.s17 + 0)
0a1b : 4c f7 0d JMP $0df7 ; (main.s18 + 0)
.s17:
0a1e : a0 00 __ LDY #$00
0a20 : aa __ __ TAX
0a21 : d0 0a __ BNE $0a2d ; (main.s20 + 0)
.s127:
0a23 : ad 62 36 LDA $3662 ; (current_page + 0)
0a26 : c9 02 __ CMP #$02
0a28 : d0 03 __ BNE $0a2d ; (main.s20 + 0)
0a2a : 4c ea 0d JMP $0dea ; (main.s125 + 0)
.s20:
0a2d : a5 1b __ LDA ACCU + 0 
0a2f : c9 64 __ CMP #$64
0a31 : d0 03 __ BNE $0a36 ; (main.s21 + 0)
0a33 : 4c 88 0d JMP $0d88 ; (main.s113 + 0)
.s21:
0a36 : a9 2a __ LDA #$2a
0a38 : a2 00 __ LDX #$00
.s22:
0a3a : 85 58 __ STA T3 + 1 
0a3c : a5 1b __ LDA ACCU + 0 
0a3e : c9 64 __ CMP #$64
0a40 : b0 03 __ BCS $0a45 ; (main.s23 + 0)
0a42 : 4c e4 0b JMP $0be4 ; (main.s75 + 0)
.s23:
0a45 : c9 71 __ CMP #$71
0a47 : d0 25 __ BNE $0a6e ; (main.s24 + 0)
.s73:
0a49 : ad 62 36 LDA $3662 ; (current_page + 0)
0a4c : 05 56 __ ORA T1 + 1 
0a4e : d0 b6 __ BNE $0a06 ; (main.l15 + 0)
.s74:
0a50 : 20 8b 2e JSR $2e8b ; (disconnect_from_server.s4 + 0)
0a53 : a9 00 __ LDA #$00
0a55 : 85 0d __ STA P0 
0a57 : 85 0e __ STA P1 
0a59 : 20 2b 0f JSR $0f2b ; (clear_screen.s4 + 0)
0a5c : a9 dd __ LDA #$dd
0a5e : 85 0f __ STA P2 
0a60 : a9 2e __ LDA #$2e
0a62 : 85 10 __ STA P3 
0a64 : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
0a67 : a9 00 __ LDA #$00
0a69 : 85 1b __ STA ACCU + 0 
0a6b : 4c 0b 09 JMP $090b ; (main.s3 + 0)
.s24:
0a6e : b0 03 __ BCS $0a73 ; (main.s25 + 0)
0a70 : 4c 71 0b JMP $0b71 ; (main.s58 + 0)
.s25:
0a73 : c9 75 __ CMP #$75
0a75 : d0 03 __ BNE $0a7a ; (main.s26 + 0)
0a77 : 4c 19 0b JMP $0b19 ; (main.s48 + 0)
.s26:
0a7a : a5 56 __ LDA T1 + 1 
0a7c : d0 88 __ BNE $0a06 ; (main.l15 + 0)
.s47:
0a7e : ad 62 36 LDA $3662 ; (current_page + 0)
0a81 : c9 02 __ CMP #$02
0a83 : f0 48 __ BEQ $0acd ; (main.s38 + 0)
.s37:
0a85 : c9 03 __ CMP #$03
0a87 : f0 03 __ BEQ $0a8c ; (main.s27 + 0)
0a89 : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s27:
0a8c : ad 66 36 LDA $3666 ; (settings_editing + 0)
0a8f : f0 f8 __ BEQ $0a89 ; (main.s37 + 4)
.s28:
0a91 : a5 1b __ LDA ACCU + 0 
0a93 : c9 30 __ CMP #$30
0a95 : 90 04 __ BCC $0a9b ; (main.s29 + 0)
.s36:
0a97 : c9 3a __ CMP #$3a
0a99 : 90 04 __ BCC $0a9f ; (main.s30 + 0)
.s29:
0a9b : c9 2e __ CMP #$2e
0a9d : d0 ea __ BNE $0a89 ; (main.s37 + 4)
.s30:
0a9f : ae 67 36 LDX $3667 ; (settings_edit_pos + 0)
0aa2 : ad 68 36 LDA $3668 ; (settings_edit_pos + 1)
0aa5 : 30 06 __ BMI $0aad ; (main.s31 + 0)
.s35:
0aa7 : d0 e0 __ BNE $0a89 ; (main.s37 + 4)
.s34:
0aa9 : e0 1e __ CPX #$1e
0aab : b0 dc __ BCS $0a89 ; (main.s37 + 4)
.s31:
0aad : 8a __ __ TXA
0aae : e8 __ __ INX
0aaf : e8 __ __ INX
0ab0 : 86 53 __ STX T0 + 0 
0ab2 : 18 __ __ CLC
0ab3 : 69 01 __ ADC #$01
0ab5 : 8d 67 36 STA $3667 ; (settings_edit_pos + 0)
0ab8 : a5 1b __ LDA ACCU + 0 
0aba : 9d 40 36 STA $3640,x ; (spentry + 0)
.s32:
0abd : a9 00 __ LDA #$00
0abf : 8d 68 36 STA $3668 ; (settings_edit_pos + 1)
0ac2 : a6 53 __ LDX T0 + 0 
0ac4 : 9d 41 36 STA $3641,x ; (uci_target + 0)
.s33:
0ac7 : 20 2b 14 JSR $142b ; (draw_settings.s4 + 0)
0aca : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s38:
0acd : a5 1b __ LDA ACCU + 0 
0acf : c9 41 __ CMP #$41
0ad1 : 90 04 __ BCC $0ad7 ; (main.s39 + 0)
.s46:
0ad3 : c9 5b __ CMP #$5b
0ad5 : 90 08 __ BCC $0adf ; (main.s41 + 0)
.s39:
0ad7 : c9 30 __ CMP #$30
0ad9 : 90 ef __ BCC $0aca ; (main.s33 + 3)
.s40:
0adb : c9 3a __ CMP #$3a
0add : b0 eb __ BCS $0aca ; (main.s33 + 3)
.s41:
0adf : ae f7 36 LDX $36f7 ; (search_query_len + 0)
0ae2 : ad f8 36 LDA $36f8 ; (search_query_len + 1)
0ae5 : 30 06 __ BMI $0aed ; (main.s42 + 0)
.s45:
0ae7 : d0 e1 __ BNE $0aca ; (main.s33 + 3)
.s44:
0ae9 : e0 1e __ CPX #$1e
0aeb : b0 dd __ BCS $0aca ; (main.s33 + 3)
.s42:
0aed : 8a __ __ TXA
0aee : 18 __ __ CLC
0aef : 69 01 __ ADC #$01
0af1 : 8d f7 36 STA $36f7 ; (search_query_len + 0)
0af4 : a5 1b __ LDA ACCU + 0 
0af6 : 9d cc 3e STA $3ecc,x ; (search_query[0] + 0)
0af9 : a9 00 __ LDA #$00
0afb : 8d f8 36 STA $36f8 ; (search_query_len + 1)
0afe : 9d cd 3e STA $3ecd,x ; (search_query[0] + 1)
0b01 : ad f7 36 LDA $36f7 ; (search_query_len + 0)
0b04 : c9 02 __ CMP #$02
0b06 : a9 18 __ LDA #$18
0b08 : 85 53 __ STA T0 + 0 
0b0a : a9 2a __ LDA #$2a
0b0c : 85 54 __ STA T0 + 1 
0b0e : b0 03 __ BCS $0b13 ; (main.s43 + 0)
0b10 : 4c f9 09 JMP $09f9 ; (main.l13 + 0)
.s43:
0b13 : 20 f9 2c JSR $2cf9 ; (do_search.s1 + 0)
0b16 : 4c f9 09 JMP $09f9 ; (main.l13 + 0)
.s48:
0b19 : a5 56 __ LDA T1 + 1 
0b1b : d0 25 __ BNE $0b42 ; (main.s49 + 0)
.s57:
0b1d : ad 62 36 LDA $3662 ; (current_page + 0)
0b20 : c9 03 __ CMP #$03
0b22 : d0 1e __ BNE $0b42 ; (main.s49 + 0)
.s53:
0b24 : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0b27 : 30 a1 __ BMI $0aca ; (main.s33 + 3)
.s56:
0b29 : 0d 64 36 ORA $3664 ; (settings_cursor + 0)
0b2c : f0 9c __ BEQ $0aca ; (main.s33 + 3)
.s54:
0b2e : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0b31 : 69 fe __ ADC #$fe
0b33 : aa __ __ TAX
0b34 : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0b37 : 69 ff __ ADC #$ff
.s55:
0b39 : 8e 64 36 STX $3664 ; (settings_cursor + 0)
0b3c : 8d 65 36 STA $3665 ; (settings_cursor + 1)
0b3f : 4c c7 0a JMP $0ac7 ; (main.s33 + 0)
.s49:
0b42 : ad f4 36 LDA $36f4 ; (cursor + 1)
0b45 : 30 83 __ BMI $0aca ; (main.s33 + 3)
.s52:
0b47 : 0d f3 36 ORA $36f3 ; (cursor + 0)
0b4a : d0 03 __ BNE $0b4f ; (main.s50 + 0)
0b4c : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s50:
0b4f : ad f3 36 LDA $36f3 ; (cursor + 0)
0b52 : 85 17 __ STA P10 
0b54 : 18 __ __ CLC
0b55 : 69 ff __ ADC #$ff
0b57 : aa __ __ TAX
0b58 : ad f4 36 LDA $36f4 ; (cursor + 1)
0b5b : 85 18 __ STA P11 
0b5d : 69 ff __ ADC #$ff
.s51:
0b5f : 8e f6 9f STX $9ff6 ; (sstack + 0)
0b62 : 8e f3 36 STX $36f3 ; (cursor + 0)
0b65 : 8d f7 9f STA $9ff7 ; (sstack + 1)
0b68 : 8d f4 36 STA $36f4 ; (cursor + 1)
0b6b : 20 2c 2a JSR $2a2c ; (update_cursor.s4 + 0)
0b6e : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s58:
0b71 : 86 57 __ STX T3 + 0 
0b73 : c9 6e __ CMP #$6e
0b75 : d0 47 __ BNE $0bbe ; (main.s59 + 0)
.s66:
0b77 : 98 __ __ TYA
0b78 : f0 f4 __ BEQ $0b6e ; (main.s51 + 15)
.s67:
0b7a : ad e9 36 LDA $36e9 ; (item_count + 0)
0b7d : 18 __ __ CLC
0b7e : 6d f5 36 ADC $36f5 ; (offset + 0)
0b81 : aa __ __ TAX
0b82 : ad ea 36 LDA $36ea ; (item_count + 1)
0b85 : 6d f6 36 ADC $36f6 ; (offset + 1)
0b88 : cd f2 36 CMP $36f2 ; (total_count + 1)
0b8b : d0 06 __ BNE $0b93 ; (main.s72 + 0)
.s69:
0b8d : ec f1 36 CPX $36f1 ; (total_count + 0)
0b90 : 4c 98 0b JMP $0b98 ; (main.s70 + 0)
.s72:
0b93 : 4d f2 36 EOR $36f2 ; (total_count + 1)
0b96 : 30 21 __ BMI $0bb9 ; (main.s71 + 0)
.s70:
0b98 : b0 d4 __ BCS $0b6e ; (main.s51 + 15)
.s68:
0b9a : ad f5 36 LDA $36f5 ; (offset + 0)
0b9d : 18 __ __ CLC
0b9e : 69 14 __ ADC #$14
0ba0 : aa __ __ TAX
0ba1 : ad f6 36 LDA $36f6 ; (offset + 1)
0ba4 : 69 00 __ ADC #$00
.s63:
0ba6 : 8e fe 9f STX $9ffe ; (sstack + 8)
0ba9 : 8d ff 9f STA $9fff ; (sstack + 9)
0bac : 20 82 2a JSR $2a82 ; (load_entries.s1 + 0)
0baf : a5 57 __ LDA T3 + 0 
0bb1 : 8d fe 9f STA $9ffe ; (sstack + 8)
0bb4 : a5 58 __ LDA T3 + 1 
0bb6 : 4c 00 0a JMP $0a00 ; (main.l14 + 0)
.s71:
0bb9 : b0 df __ BCS $0b9a ; (main.s68 + 0)
0bbb : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s59:
0bbe : c9 70 __ CMP #$70
0bc0 : f0 03 __ BEQ $0bc5 ; (main.s60 + 0)
0bc2 : 4c 7a 0a JMP $0a7a ; (main.s26 + 0)
.s60:
0bc5 : 98 __ __ TYA
0bc6 : f0 f3 __ BEQ $0bbb ; (main.s71 + 2)
.s61:
0bc8 : ad f6 36 LDA $36f6 ; (offset + 1)
0bcb : 30 ee __ BMI $0bbb ; (main.s71 + 2)
.s65:
0bcd : 0d f5 36 ORA $36f5 ; (offset + 0)
0bd0 : f0 e9 __ BEQ $0bbb ; (main.s71 + 2)
.s62:
0bd2 : ad f5 36 LDA $36f5 ; (offset + 0)
0bd5 : e9 14 __ SBC #$14
0bd7 : aa __ __ TAX
0bd8 : ad f6 36 LDA $36f6 ; (offset + 1)
0bdb : e9 00 __ SBC #$00
0bdd : 10 c7 __ BPL $0ba6 ; (main.s63 + 0)
.s64:
0bdf : a9 00 __ LDA #$00
0be1 : aa __ __ TAX
0be2 : f0 c2 __ BEQ $0ba6 ; (main.s63 + 0)
.s75:
0be4 : c9 2f __ CMP #$2f
0be6 : d0 37 __ BNE $0c1f ; (main.s76 + 0)
.s111:
0be8 : ad 62 36 LDA $3662 ; (current_page + 0)
0beb : 05 56 __ ORA T1 + 1 
0bed : d0 cc __ BNE $0bbb ; (main.s71 + 2)
.s112:
0bef : 8d f5 36 STA $36f5 ; (offset + 0)
0bf2 : 8d f6 36 STA $36f6 ; (offset + 1)
0bf5 : 8d f3 36 STA $36f3 ; (cursor + 0)
0bf8 : 8d f4 36 STA $36f4 ; (cursor + 1)
0bfb : 8d f1 36 STA $36f1 ; (total_count + 0)
0bfe : 8d f2 36 STA $36f2 ; (total_count + 1)
0c01 : 8d e9 36 STA $36e9 ; (item_count + 0)
0c04 : 8d ea 36 STA $36ea ; (item_count + 1)
0c07 : 8d f7 36 STA $36f7 ; (search_query_len + 0)
0c0a : 8d f8 36 STA $36f8 ; (search_query_len + 1)
0c0d : 8d cc 3e STA $3ecc ; (search_query[0] + 0)
0c10 : 8d 63 36 STA $3663 ; (current_page + 1)
0c13 : a9 02 __ LDA #$02
0c15 : 8d 62 36 STA $3662 ; (current_page + 0)
0c18 : a9 2a __ LDA #$2a
0c1a : a2 18 __ LDX #$18
0c1c : 4c f5 09 JMP $09f5 ; (main.l170 + 0)
.s76:
0c1f : 90 78 __ BCC $0c99 ; (main.s86 + 0)
.s77:
0c21 : c9 3e __ CMP #$3e
0c23 : d0 42 __ BNE $0c67 ; (main.s78 + 0)
.s82:
0c25 : ad 62 36 LDA $3662 ; (current_page + 0)
0c28 : 05 56 __ ORA T1 + 1 
0c2a : d0 8f __ BNE $0bbb ; (main.s71 + 2)
.s83:
0c2c : 8d fe 9f STA $9ffe ; (sstack + 8)
0c2f : 8d ff 9f STA $9fff ; (sstack + 9)
0c32 : ad f3 36 LDA $36f3 ; (cursor + 0)
0c35 : 85 1c __ STA ACCU + 1 
0c37 : ad f4 36 LDA $36f4 ; (cursor + 1)
0c3a : 4a __ __ LSR
0c3b : 66 1c __ ROR ACCU + 1 
0c3d : 6a __ __ ROR
0c3e : 66 1c __ ROR ACCU + 1 
0c40 : 6a __ __ ROR
0c41 : 66 1c __ ROR ACCU + 1 
0c43 : 29 c0 __ AND #$c0
0c45 : 6a __ __ ROR
0c46 : 69 00 __ ADC #$00
0c48 : 85 53 __ STA T0 + 0 
0c4a : a9 40 __ LDA #$40
0c4c : 65 1c __ ADC ACCU + 1 
0c4e : 85 54 __ STA T0 + 1 
0c50 : a0 ff __ LDY #$ff
.l84:
0c52 : c8 __ __ INY
0c53 : b1 53 __ LDA (T0 + 0),y 
0c55 : 99 80 42 STA $4280,y ; (current_category[0] + 0)
0c58 : d0 f8 __ BNE $0c52 ; (main.l84 + 0)
.s85:
0c5a : 20 82 2a JSR $2a82 ; (load_entries.s1 + 0)
0c5d : a9 80 __ LDA #$80
0c5f : 8d fe 9f STA $9ffe ; (sstack + 8)
0c62 : a9 42 __ LDA #$42
0c64 : 4c 00 0a JMP $0a00 ; (main.l14 + 0)
.s78:
0c67 : c9 63 __ CMP #$63
0c69 : f0 03 __ BEQ $0c6e ; (main.s79 + 0)
0c6b : 4c 7a 0a JMP $0a7a ; (main.s26 + 0)
.s79:
0c6e : ad 62 36 LDA $3662 ; (current_page + 0)
0c71 : 05 56 __ ORA T1 + 1 
0c73 : f0 03 __ BEQ $0c78 ; (main.s80 + 0)
0c75 : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s80:
0c78 : 8d 66 36 STA $3666 ; (settings_editing + 0)
0c7b : 8d 64 36 STA $3664 ; (settings_cursor + 0)
0c7e : 8d 65 36 STA $3665 ; (settings_cursor + 1)
0c81 : 8d 63 36 STA $3663 ; (current_page + 1)
0c84 : a9 03 __ LDA #$03
0c86 : 8d 62 36 STA $3662 ; (current_page + 0)
.s81:
0c89 : 20 79 13 JSR $1379 ; (strlen@proxy + 0)
0c8c : a5 1b __ LDA ACCU + 0 
0c8e : 8d 67 36 STA $3667 ; (settings_edit_pos + 0)
0c91 : a5 1c __ LDA ACCU + 1 
0c93 : 8d 68 36 STA $3668 ; (settings_edit_pos + 1)
0c96 : 4c c7 0a JMP $0ac7 ; (main.s33 + 0)
.s86:
0c99 : c9 08 __ CMP #$08
0c9b : f0 78 __ BEQ $0d15 ; (main.s99 + 0)
.s87:
0c9d : c9 0d __ CMP #$0d
0c9f : d0 ca __ BNE $0c6b ; (main.s78 + 4)
.s88:
0ca1 : ad 62 36 LDA $3662 ; (current_page + 0)
0ca4 : 05 56 __ ORA T1 + 1 
0ca6 : f0 84 __ BEQ $0c2c ; (main.s83 + 0)
.s89:
0ca8 : a5 56 __ LDA T1 + 1 
0caa : d0 07 __ BNE $0cb3 ; (main.s90 + 0)
.s98:
0cac : ad 62 36 LDA $3662 ; (current_page + 0)
0caf : c9 03 __ CMP #$03
0cb1 : f0 21 __ BEQ $0cd4 ; (main.s93 + 0)
.s90:
0cb3 : ad ea 36 LDA $36ea ; (item_count + 1)
0cb6 : 30 bd __ BMI $0c75 ; (main.s79 + 7)
.s92:
0cb8 : 0d e9 36 ORA $36e9 ; (item_count + 0)
0cbb : f0 b8 __ BEQ $0c75 ; (main.s79 + 7)
.s91:
0cbd : ad f3 36 LDA $36f3 ; (cursor + 0)
0cc0 : 0a __ __ ASL
0cc1 : aa __ __ TAX
0cc2 : bd a4 3e LDA $3ea4,x ; (item_ids[0] + 0)
0cc5 : 8d fe 9f STA $9ffe ; (sstack + 8)
0cc8 : bd a5 3e LDA $3ea5,x ; (item_ids[0] + 1)
0ccb : 8d ff 9f STA $9fff ; (sstack + 9)
0cce : 20 94 2c JSR $2c94 ; (run_entry.s4 + 0)
0cd1 : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s93:
0cd4 : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0cd7 : 0d 65 36 ORA $3665 ; (settings_cursor + 1)
0cda : d0 0c __ BNE $0ce8 ; (main.s94 + 0)
.s97:
0cdc : cd 66 36 CMP $3666 ; (settings_editing + 0)
0cdf : 2a __ __ ROL
0ce0 : 8d 66 36 STA $3666 ; (settings_editing + 0)
0ce3 : d0 a4 __ BNE $0c89 ; (main.s81 + 0)
0ce5 : 4c c7 0a JMP $0ac7 ; (main.s33 + 0)
.s94:
0ce8 : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0ceb : d0 e4 __ BNE $0cd1 ; (main.s91 + 20)
.s96:
0ced : ae 64 36 LDX $3664 ; (settings_cursor + 0)
0cf0 : ca __ __ DEX
0cf1 : d0 de __ BNE $0cd1 ; (main.s91 + 20)
.s95:
0cf3 : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
0cf6 : 20 ee 35 JSR $35ee ; (print_at@proxy + 0)
0cf9 : 20 29 22 JSR $2229 ; (save_settings.s4 + 0)
0cfc : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
0cff : a9 2c __ LDA #$2c
0d01 : 85 10 __ STA P3 
0d03 : a9 8d __ LDA #$8d
0d05 : 85 0f __ STA P2 
0d07 : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
0d0a : a9 00 __ LDA #$00
.s174:
0d0c : 8d 62 36 STA $3662 ; (current_page + 0)
0d0f : 8d 63 36 STA $3663 ; (current_page + 1)
0d12 : 4c f1 09 JMP $09f1 ; (main.l171 + 0)
.s99:
0d15 : a5 56 __ LDA T1 + 1 
0d17 : d0 69 __ BNE $0d82 ; (main.s100 + 0)
.s110:
0d19 : ad 62 36 LDA $3662 ; (current_page + 0)
0d1c : c9 03 __ CMP #$03
0d1e : d0 1c __ BNE $0d3c ; (main.s105 + 0)
.s106:
0d20 : ad 66 36 LDA $3666 ; (settings_editing + 0)
0d23 : f0 e7 __ BEQ $0d0c ; (main.s174 + 0)
.s107:
0d25 : ad 67 36 LDA $3667 ; (settings_edit_pos + 0)
0d28 : 85 53 __ STA T0 + 0 
0d2a : ad 68 36 LDA $3668 ; (settings_edit_pos + 1)
0d2d : 30 a2 __ BMI $0cd1 ; (main.s91 + 20)
.s109:
0d2f : 05 53 __ ORA T0 + 0 
0d31 : f0 9e __ BEQ $0cd1 ; (main.s91 + 20)
.s108:
0d33 : a6 53 __ LDX T0 + 0 
0d35 : ca __ __ DEX
0d36 : 8e 67 36 STX $3667 ; (settings_edit_pos + 0)
0d39 : 4c bd 0a JMP $0abd ; (main.s32 + 0)
.s105:
0d3c : c9 02 __ CMP #$02
0d3e : d0 42 __ BNE $0d82 ; (main.s100 + 0)
.s101:
0d40 : ad f7 36 LDA $36f7 ; (search_query_len + 0)
0d43 : 85 53 __ STA T0 + 0 
0d45 : ad f8 36 LDA $36f8 ; (search_query_len + 1)
0d48 : 10 03 __ BPL $0d4d ; (main.s104 + 0)
0d4a : 4c ee 09 JMP $09ee ; (main.l172 + 0)
.s104:
0d4d : 05 53 __ ORA T0 + 0 
0d4f : f0 f9 __ BEQ $0d4a ; (main.s101 + 10)
.s102:
0d51 : a6 53 __ LDX T0 + 0 
0d53 : ca __ __ DEX
0d54 : 8e f7 36 STX $36f7 ; (search_query_len + 0)
0d57 : a9 00 __ LDA #$00
0d59 : 8d f8 36 STA $36f8 ; (search_query_len + 1)
0d5c : 9d cc 3e STA $3ecc,x ; (search_query[0] + 0)
0d5f : ad f7 36 LDA $36f7 ; (search_query_len + 0)
0d62 : c9 02 __ CMP #$02
0d64 : a9 18 __ LDA #$18
0d66 : 85 53 __ STA T0 + 0 
0d68 : a9 2a __ LDA #$2a
0d6a : 85 54 __ STA T0 + 1 
0d6c : 90 03 __ BCC $0d71 ; (main.s103 + 0)
0d6e : 4c 13 0b JMP $0b13 ; (main.s43 + 0)
.s103:
0d71 : a9 00 __ LDA #$00
0d73 : 8d f1 36 STA $36f1 ; (total_count + 0)
0d76 : 8d f2 36 STA $36f2 ; (total_count + 1)
0d79 : 8d e9 36 STA $36e9 ; (item_count + 0)
0d7c : 8d ea 36 STA $36ea ; (item_count + 1)
0d7f : 4c f9 09 JMP $09f9 ; (main.l13 + 0)
.s100:
0d82 : 98 __ __ TYA
0d83 : d0 c5 __ BNE $0d4a ; (main.s101 + 10)
0d85 : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s113:
0d88 : a5 56 __ LDA T1 + 1 
0d8a : d0 07 __ BNE $0d93 ; (main.s114 + 0)
.s124:
0d8c : ad 62 36 LDA $3662 ; (current_page + 0)
0d8f : c9 03 __ CMP #$03
0d91 : f0 3c __ BEQ $0dcf ; (main.s120 + 0)
.s114:
0d93 : ad e9 36 LDA $36e9 ; (item_count + 0)
0d96 : 38 __ __ SEC
0d97 : e9 01 __ SBC #$01
0d99 : 85 53 __ STA T0 + 0 
0d9b : ad ea 36 LDA $36ea ; (item_count + 1)
0d9e : e9 00 __ SBC #$00
0da0 : 85 54 __ STA T0 + 1 
0da2 : ad f4 36 LDA $36f4 ; (cursor + 1)
0da5 : c5 54 __ CMP T0 + 1 
0da7 : d0 08 __ BNE $0db1 ; (main.s119 + 0)
.s116:
0da9 : ad f3 36 LDA $36f3 ; (cursor + 0)
0dac : c5 53 __ CMP T0 + 0 
0dae : 4c b5 0d JMP $0db5 ; (main.s117 + 0)
.s119:
0db1 : 45 54 __ EOR T0 + 1 
0db3 : 30 15 __ BMI $0dca ; (main.s118 + 0)
.s117:
0db5 : b0 ce __ BCS $0d85 ; (main.s100 + 3)
.s115:
0db7 : ad f3 36 LDA $36f3 ; (cursor + 0)
0dba : 85 17 __ STA P10 
0dbc : 18 __ __ CLC
0dbd : 69 01 __ ADC #$01
0dbf : aa __ __ TAX
0dc0 : ad f4 36 LDA $36f4 ; (cursor + 1)
0dc3 : 85 18 __ STA P11 
0dc5 : 69 00 __ ADC #$00
0dc7 : 4c 5f 0b JMP $0b5f ; (main.s51 + 0)
.s118:
0dca : b0 eb __ BCS $0db7 ; (main.s115 + 0)
0dcc : 4c 06 0a JMP $0a06 ; (main.l15 + 0)
.s120:
0dcf : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0dd2 : 30 07 __ BMI $0ddb ; (main.s121 + 0)
.s123:
0dd4 : d0 f6 __ BNE $0dcc ; (main.s118 + 2)
.s122:
0dd6 : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0dd9 : d0 f1 __ BNE $0dcc ; (main.s118 + 2)
.s121:
0ddb : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0dde : 18 __ __ CLC
0ddf : 69 01 __ ADC #$01
0de1 : aa __ __ TAX
0de2 : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0de5 : 69 00 __ ADC #$00
0de7 : 4c 39 0b JMP $0b39 ; (main.s55 + 0)
.s125:
0dea : a5 1b __ LDA ACCU + 0 
0dec : c9 64 __ CMP #$64
0dee : f0 a3 __ BEQ $0d93 ; (main.s114 + 0)
.s126:
0df0 : a9 2a __ LDA #$2a
0df2 : a2 18 __ LDX #$18
0df4 : 4c 3a 0a JMP $0a3a ; (main.s22 + 0)
.s18:
0df7 : a9 00 __ LDA #$00
0df9 : 85 56 __ STA T1 + 1 
0dfb : a5 1b __ LDA ACCU + 0 
0dfd : c9 64 __ CMP #$64
0dff : f0 92 __ BEQ $0d93 ; (main.s114 + 0)
.s128:
0e01 : a9 42 __ LDA #$42
0e03 : a2 80 __ LDX #$80
0e05 : 4c 3a 0a JMP $0a3a ; (main.s22 + 0)
.l130:
0e08 : 20 f6 15 JSR $15f6 ; (get_key.s1 + 0)
0e0b : a5 1b __ LDA ACCU + 0 
0e0d : c9 75 __ CMP #$75
0e0f : d0 03 __ BNE $0e14 ; (main.s131 + 0)
0e11 : 4c 06 0f JMP $0f06 ; (main.s163 + 0)
.s131:
0e14 : aa __ __ TAX
0e15 : e0 64 __ CPX #$64
0e17 : d0 03 __ BNE $0e1c ; (main.s132 + 0)
0e19 : 4c dd 0e JMP $0edd ; (main.s157 + 0)
.s132:
0e1c : e0 0d __ CPX #$0d
0e1e : f0 77 __ BEQ $0e97 ; (main.s151 + 0)
.s133:
0e20 : e0 08 __ CPX #$08
0e22 : f0 4d __ BEQ $0e71 ; (main.s146 + 0)
.s134:
0e24 : ad 66 36 LDA $3666 ; (settings_editing + 0)
0e27 : f0 36 __ BEQ $0e5f ; (main.s135 + 0)
.s137:
0e29 : e0 30 __ CPX #$30
0e2b : 90 04 __ BCC $0e31 ; (main.s138 + 0)
.s145:
0e2d : e0 3a __ CPX #$3a
0e2f : 90 04 __ BCC $0e35 ; (main.s139 + 0)
.s138:
0e31 : e0 2e __ CPX #$2e
0e33 : d0 2a __ BNE $0e5f ; (main.s135 + 0)
.s139:
0e35 : ac 67 36 LDY $3667 ; (settings_edit_pos + 0)
0e38 : ad 68 36 LDA $3668 ; (settings_edit_pos + 1)
0e3b : 30 0a __ BMI $0e47 ; (main.s140 + 0)
.s144:
0e3d : d0 20 __ BNE $0e5f ; (main.s135 + 0)
.s143:
0e3f : 84 53 __ STY T0 + 0 
0e41 : a5 53 __ LDA T0 + 0 
0e43 : c9 1e __ CMP #$1e
0e45 : b0 18 __ BCS $0e5f ; (main.s135 + 0)
.s140:
0e47 : c8 __ __ INY
0e48 : 8c 67 36 STY $3667 ; (settings_edit_pos + 0)
0e4b : 8a __ __ TXA
0e4c : c8 __ __ INY
0e4d : 84 53 __ STY T0 + 0 
0e4f : 99 40 36 STA $3640,y ; (spentry + 0)
.s141:
0e52 : a9 00 __ LDA #$00
0e54 : 8d 68 36 STA $3668 ; (settings_edit_pos + 1)
0e57 : a6 53 __ LDX T0 + 0 
0e59 : 9d 41 36 STA $3641,x ; (uci_target + 0)
.s142:
0e5c : 20 2b 14 JSR $142b ; (draw_settings.s4 + 0)
.s135:
0e5f : ad 63 36 LDA $3663 ; (current_page + 1)
0e62 : f0 03 __ BEQ $0e67 ; (main.s136 + 0)
0e64 : 4c e0 09 JMP $09e0 ; (main.s11 + 0)
.s136:
0e67 : ad 62 36 LDA $3662 ; (current_page + 0)
0e6a : c9 03 __ CMP #$03
0e6c : f0 9a __ BEQ $0e08 ; (main.l130 + 0)
0e6e : 4c e0 09 JMP $09e0 ; (main.s11 + 0)
.s146:
0e71 : ad 66 36 LDA $3666 ; (settings_editing + 0)
0e74 : f0 17 __ BEQ $0e8d ; (main.s147 + 0)
.s148:
0e76 : ad 67 36 LDA $3667 ; (settings_edit_pos + 0)
0e79 : 85 53 __ STA T0 + 0 
0e7b : ad 68 36 LDA $3668 ; (settings_edit_pos + 1)
0e7e : 30 df __ BMI $0e5f ; (main.s135 + 0)
.s150:
0e80 : 05 53 __ ORA T0 + 0 
0e82 : f0 db __ BEQ $0e5f ; (main.s135 + 0)
.s149:
0e84 : a6 53 __ LDX T0 + 0 
0e86 : ca __ __ DEX
0e87 : 8e 67 36 STX $3667 ; (settings_edit_pos + 0)
0e8a : 4c 52 0e JMP $0e52 ; (main.s141 + 0)
.s147:
0e8d : a9 00 __ LDA #$00
0e8f : 8d 62 36 STA $3662 ; (current_page + 0)
0e92 : 8d 63 36 STA $3663 ; (current_page + 1)
0e95 : f0 c8 __ BEQ $0e5f ; (main.s135 + 0)
.s151:
0e97 : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0e9a : 0d 65 36 ORA $3665 ; (settings_cursor + 1)
0e9d : d0 19 __ BNE $0eb8 ; (main.s152 + 0)
.s155:
0e9f : cd 66 36 CMP $3666 ; (settings_editing + 0)
0ea2 : 2a __ __ ROL
0ea3 : 8d 66 36 STA $3666 ; (settings_editing + 0)
0ea6 : f0 b4 __ BEQ $0e5c ; (main.s142 + 0)
.s156:
0ea8 : 20 79 13 JSR $1379 ; (strlen@proxy + 0)
0eab : a5 1b __ LDA ACCU + 0 
0ead : 8d 67 36 STA $3667 ; (settings_edit_pos + 0)
0eb0 : a5 1c __ LDA ACCU + 1 
0eb2 : 8d 68 36 STA $3668 ; (settings_edit_pos + 1)
0eb5 : 4c 5c 0e JMP $0e5c ; (main.s142 + 0)
.s152:
0eb8 : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0ebb : d0 a2 __ BNE $0e5f ; (main.s135 + 0)
.s154:
0ebd : ae 64 36 LDX $3664 ; (settings_cursor + 0)
0ec0 : ca __ __ DEX
0ec1 : d0 9c __ BNE $0e5f ; (main.s135 + 0)
.s153:
0ec3 : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
0ec6 : 20 ee 35 JSR $35ee ; (print_at@proxy + 0)
0ec9 : 20 29 22 JSR $2229 ; (save_settings.s4 + 0)
0ecc : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
0ecf : a9 23 __ LDA #$23
0ed1 : 85 10 __ STA P3 
0ed3 : a9 1f __ LDA #$1f
0ed5 : 85 0f __ STA P2 
0ed7 : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
0eda : 4c 8d 0e JMP $0e8d ; (main.s147 + 0)
.s157:
0edd : ad 66 36 LDA $3666 ; (settings_editing + 0)
0ee0 : f0 03 __ BEQ $0ee5 ; (main.s158 + 0)
0ee2 : 4c 20 0e JMP $0e20 ; (main.s133 + 0)
.s158:
0ee5 : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0ee8 : 30 07 __ BMI $0ef1 ; (main.s159 + 0)
.s162:
0eea : d0 f6 __ BNE $0ee2 ; (main.s157 + 5)
.s161:
0eec : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0eef : d0 f1 __ BNE $0ee2 ; (main.s157 + 5)
.s159:
0ef1 : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0ef4 : 18 __ __ CLC
0ef5 : 69 01 __ ADC #$01
0ef7 : aa __ __ TAX
0ef8 : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0efb : 69 00 __ ADC #$00
.s160:
0efd : 8e 64 36 STX $3664 ; (settings_cursor + 0)
0f00 : 8d 65 36 STA $3665 ; (settings_cursor + 1)
0f03 : 4c 5c 0e JMP $0e5c ; (main.s142 + 0)
.s163:
0f06 : aa __ __ TAX
0f07 : ad 66 36 LDA $3666 ; (settings_editing + 0)
0f0a : f0 03 __ BEQ $0f0f ; (main.s164 + 0)
0f0c : 4c 1c 0e JMP $0e1c ; (main.s132 + 0)
.s164:
0f0f : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0f12 : 30 f8 __ BMI $0f0c ; (main.s163 + 6)
.s166:
0f14 : 0d 64 36 ORA $3664 ; (settings_cursor + 0)
0f17 : f0 f3 __ BEQ $0f0c ; (main.s163 + 6)
.s165:
0f19 : ad 64 36 LDA $3664 ; (settings_cursor + 0)
0f1c : 69 fe __ ADC #$fe
0f1e : aa __ __ TAX
0f1f : ad 65 36 LDA $3665 ; (settings_cursor + 1)
0f22 : 69 ff __ ADC #$ff
0f24 : 4c fd 0e JMP $0efd ; (main.s160 + 0)
--------------------------------------------------------------------
clear_screen@proxy: ; clear_screen@proxy
0f27 : a9 07 __ LDA #$07
0f29 : 85 11 __ STA P4 
--------------------------------------------------------------------
clear_screen: ; clear_screen()->void
;  72, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
0f2b : a9 20 __ LDA #$20
0f2d : a2 fa __ LDX #$fa
.l6:
0f2f : ca __ __ DEX
0f30 : 9d 00 04 STA $0400,x 
0f33 : 9d fa 04 STA $04fa,x 
0f36 : 9d f4 05 STA $05f4,x 
0f39 : 9d ee 06 STA $06ee,x 
0f3c : d0 f1 __ BNE $0f2f ; (clear_screen.l6 + 0)
.s5:
0f3e : a9 0e __ LDA #$0e
0f40 : a2 fa __ LDX #$fa
.l7:
0f42 : ca __ __ DEX
0f43 : 9d 00 d8 STA $d800,x 
0f46 : 9d fa d8 STA $d8fa,x 
0f49 : 9d f4 d9 STA $d9f4,x 
0f4c : 9d ee da STA $daee,x 
0f4f : d0 f1 __ BNE $0f42 ; (clear_screen.l7 + 0)
.s3:
0f51 : 60 __ __ RTS
--------------------------------------------------------------------
debug_key: ; debug_key(u8,bool)->void
; 420, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
0f52 : a5 18 __ LDA P11 ; (k + 0)
0f54 : 8d f8 9f STA $9ff8 ; (sstack + 2)
0f57 : c9 40 __ CMP #$40
0f59 : a9 00 __ LDA #$00
0f5b : 8d f9 9f STA $9ff9 ; (sstack + 3)
0f5e : a9 e1 __ LDA #$e1
0f60 : 8d f6 9f STA $9ff6 ; (sstack + 0)
0f63 : a9 21 __ LDA #$21
0f65 : 8d f7 9f STA $9ff7 ; (sstack + 1)
0f68 : 90 04 __ BCC $0f6e ; (debug_key.s7 + 0)
.s5:
0f6a : a9 3f __ LDA #$3f
0f6c : b0 10 __ BCS $0f7e ; (debug_key.s6 + 0)
.s7:
0f6e : ad fe 9f LDA $9ffe ; (sstack + 8)
0f71 : f0 06 __ BEQ $0f79 ; (debug_key.s8 + 0)
.s9:
0f73 : a5 18 __ LDA P11 ; (k + 0)
0f75 : 69 40 __ ADC #$40
0f77 : 85 18 __ STA P11 ; (k + 0)
.s8:
0f79 : a6 18 __ LDX P11 ; (k + 0)
0f7b : bd 69 36 LDA $3669,x ; (keyb_codes[0] + 0)
.s6:
0f7e : 8d fa 9f STA $9ffa ; (sstack + 4)
0f81 : a9 b8 __ LDA #$b8
0f83 : 85 16 __ STA P9 
0f85 : a9 00 __ LDA #$00
0f87 : 8d fb 9f STA $9ffb ; (sstack + 5)
0f8a : a9 9f __ LDA #$9f
0f8c : 85 17 __ STA P10 
0f8e : 20 4e 17 JSR $174e ; (sprintf.s1 + 0)
0f91 : a9 1c __ LDA #$1c
0f93 : 85 0d __ STA P0 
0f95 : a9 9f __ LDA #$9f
0f97 : 85 10 __ STA P3 
0f99 : a9 18 __ LDA #$18
0f9b : 85 0e __ STA P1 
0f9d : a9 b8 __ LDA #$b8
0f9f : 85 0f __ STA P2 
--------------------------------------------------------------------
print_at: ; print_at(u8,u8,const u8*)->void
;  78, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
0fa1 : a5 0e __ LDA P1 ; (y + 0)
0fa3 : 0a __ __ ASL
0fa4 : 85 1b __ STA ACCU + 0 
0fa6 : a9 00 __ LDA #$00
0fa8 : 2a __ __ ROL
0fa9 : 06 1b __ ASL ACCU + 0 
0fab : 2a __ __ ROL
0fac : aa __ __ TAX
0fad : a5 1b __ LDA ACCU + 0 
0faf : 65 0e __ ADC P1 ; (y + 0)
0fb1 : 85 43 __ STA T1 + 0 
0fb3 : 8a __ __ TXA
0fb4 : 69 00 __ ADC #$00
0fb6 : 06 43 __ ASL T1 + 0 
0fb8 : 2a __ __ ROL
0fb9 : 06 43 __ ASL T1 + 0 
0fbb : 2a __ __ ROL
0fbc : 06 43 __ ASL T1 + 0 
0fbe : 2a __ __ ROL
0fbf : aa __ __ TAX
0fc0 : a0 00 __ LDY #$00
0fc2 : b1 0f __ LDA (P2),y ; (text + 0)
0fc4 : f0 4e __ BEQ $1014 ; (print_at.s3 + 0)
.s14:
0fc6 : a5 43 __ LDA T1 + 0 
0fc8 : 65 0d __ ADC P0 ; (x + 0)
0fca : 85 43 __ STA T1 + 0 
0fcc : 8a __ __ TXA
0fcd : 69 04 __ ADC #$04
0fcf : 85 44 __ STA T1 + 1 
0fd1 : a6 0f __ LDX P2 ; (text + 0)
.l5:
0fd3 : 86 1b __ STX ACCU + 0 
0fd5 : 8a __ __ TXA
0fd6 : 18 __ __ CLC
0fd7 : 69 01 __ ADC #$01
0fd9 : aa __ __ TAX
0fda : a5 10 __ LDA P3 ; (text + 1)
0fdc : 85 1c __ STA ACCU + 1 
0fde : 69 00 __ ADC #$00
0fe0 : 85 10 __ STA P3 ; (text + 1)
0fe2 : a0 00 __ LDY #$00
0fe4 : b1 1b __ LDA (ACCU + 0),y 
0fe6 : c9 61 __ CMP #$61
0fe8 : 90 09 __ BCC $0ff3 ; (print_at.s6 + 0)
.s12:
0fea : c9 7b __ CMP #$7b
0fec : b0 05 __ BCS $0ff3 ; (print_at.s6 + 0)
.s13:
0fee : 69 a0 __ ADC #$a0
0ff0 : 4c 06 10 JMP $1006 ; (print_at.s7 + 0)
.s6:
0ff3 : c9 41 __ CMP #$41
0ff5 : 90 0f __ BCC $1006 ; (print_at.s7 + 0)
.s8:
0ff7 : c9 5b __ CMP #$5b
0ff9 : b0 05 __ BCS $1000 ; (print_at.s9 + 0)
.s11:
0ffb : 69 c0 __ ADC #$c0
0ffd : 4c 06 10 JMP $1006 ; (print_at.s7 + 0)
.s9:
1000 : c9 7c __ CMP #$7c
1002 : d0 02 __ BNE $1006 ; (print_at.s7 + 0)
.s10:
1004 : a9 20 __ LDA #$20
.s7:
1006 : 91 43 __ STA (T1 + 0),y 
1008 : e6 43 __ INC T1 + 0 
100a : d0 02 __ BNE $100e ; (print_at.s16 + 0)
.s15:
100c : e6 44 __ INC T1 + 1 
.s16:
100e : a0 01 __ LDY #$01
1010 : b1 1b __ LDA (ACCU + 0),y 
1012 : d0 bf __ BNE $0fd3 ; (print_at.l5 + 0)
.s3:
1014 : 60 __ __ RTS
--------------------------------------------------------------------
1015 : __ __ __ BYT 61 73 73 65 6d 62 6c 79 36 34 20 62 72 6f 77 73 : assembly64 brows
1025 : __ __ __ BYT 65 72 00                                        : er.
--------------------------------------------------------------------
1028 : __ __ __ BYT 63 68 65 63 6b 69 6e 67 20 75 6c 74 69 6d 61 74 : checking ultimat
1038 : __ __ __ BYT 65 2e 2e 2e 00                                  : e....
--------------------------------------------------------------------
uci_sendcommand: ; uci_sendcommand(u8*,i16)->void
; 119, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
103d : ad 41 36 LDA $3641 ; (uci_target + 0)
1040 : a0 00 __ LDY #$00
1042 : 91 0d __ STA (P0),y ; (bytes + 0)
.l5:
1044 : ad 1c df LDA $df1c 
1047 : 29 20 __ AND #$20
1049 : d0 f9 __ BNE $1044 ; (uci_sendcommand.l5 + 0)
.s6:
104b : ad 1c df LDA $df1c 
104e : 29 10 __ AND #$10
1050 : d0 f2 __ BNE $1044 ; (uci_sendcommand.l5 + 0)
.s7:
1052 : a5 10 __ LDA P3 ; (count + 1)
1054 : 30 2a __ BMI $1080 ; (uci_sendcommand.s8 + 0)
.s13:
1056 : 05 0f __ ORA P2 ; (count + 0)
1058 : f0 26 __ BEQ $1080 ; (uci_sendcommand.s8 + 0)
.s12:
105a : a5 0f __ LDA P2 ; (count + 0)
105c : 85 1b __ STA ACCU + 0 
105e : a5 0d __ LDA P0 ; (bytes + 0)
1060 : 85 43 __ STA T2 + 0 
1062 : a5 0e __ LDA P1 ; (bytes + 1)
1064 : 85 44 __ STA T2 + 1 
1066 : a0 00 __ LDY #$00
1068 : a6 10 __ LDX P3 ; (count + 1)
.l14:
106a : b1 43 __ LDA (T2 + 0),y 
106c : 8d 1d df STA $df1d 
106f : c8 __ __ INY
1070 : d0 02 __ BNE $1074 ; (uci_sendcommand.s19 + 0)
.s18:
1072 : e6 44 __ INC T2 + 1 
.s19:
1074 : a5 1b __ LDA ACCU + 0 
1076 : d0 01 __ BNE $1079 ; (uci_sendcommand.s16 + 0)
.s15:
1078 : ca __ __ DEX
.s16:
1079 : c6 1b __ DEC ACCU + 0 
107b : d0 ed __ BNE $106a ; (uci_sendcommand.l14 + 0)
.s17:
107d : 8a __ __ TXA
107e : d0 ea __ BNE $106a ; (uci_sendcommand.l14 + 0)
.s8:
1080 : a9 01 __ LDA #$01
1082 : 8d 1c df STA $df1c 
1085 : ad 1c df LDA $df1c 
1088 : 29 08 __ AND #$08
108a : f0 07 __ BEQ $1093 ; (uci_sendcommand.l9 + 0)
.s11:
108c : a9 08 __ LDA #$08
108e : 8d 1c df STA $df1c 
1091 : d0 b1 __ BNE $1044 ; (uci_sendcommand.l5 + 0)
.l9:
1093 : ad 1c df LDA $df1c 
1096 : 29 20 __ AND #$20
1098 : d0 07 __ BNE $10a1 ; (uci_sendcommand.s3 + 0)
.s10:
109a : ad 1c df LDA $df1c 
109d : 29 10 __ AND #$10
109f : d0 f2 __ BNE $1093 ; (uci_sendcommand.l9 + 0)
.s3:
10a1 : 60 __ __ RTS
--------------------------------------------------------------------
uci_readdata: ; uci_readdata()->i16
; 120, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
10a2 : a9 00 __ LDA #$00
10a4 : 8d 1c 37 STA $371c ; (uci_data[0] + 0)
10a7 : a2 1c __ LDX #$1c
10a9 : 86 43 __ STX T1 + 0 
10ab : a8 __ __ TAY
10ac : f0 0d __ BEQ $10bb ; (uci_readdata.l5 + 0)
.s7:
10ae : ad 1e df LDA $df1e 
10b1 : 91 43 __ STA (T1 + 0),y 
10b3 : 98 __ __ TYA
10b4 : 18 __ __ CLC
10b5 : 69 01 __ ADC #$01
10b7 : a8 __ __ TAY
10b8 : 8a __ __ TXA
10b9 : 69 00 __ ADC #$00
.l5:
10bb : aa __ __ TAX
10bc : 18 __ __ CLC
10bd : 69 37 __ ADC #$37
10bf : 85 44 __ STA T1 + 1 
10c1 : 2c 1c df BIT $df1c 
10c4 : 30 e8 __ BMI $10ae ; (uci_readdata.s7 + 0)
.s6:
10c6 : 86 1c __ STX ACCU + 1 
10c8 : 84 1b __ STY ACCU + 0 
10ca : a9 00 __ LDA #$00
10cc : 91 43 __ STA (T1 + 0),y 
.s3:
10ce : 60 __ __ RTS
--------------------------------------------------------------------
uci_readstatus: ; uci_readstatus()->void
; 121, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
10cf : a9 00 __ LDA #$00
10d1 : 8d 00 3f STA $3f00 ; (uci_status[0] + 0)
10d4 : a2 00 __ LDX #$00
10d6 : 86 1b __ STX ACCU + 0 
10d8 : a8 __ __ TAY
10d9 : f0 0d __ BEQ $10e8 ; (uci_readstatus.l5 + 0)
.s7:
10db : ad 1f df LDA $df1f 
10de : 91 1b __ STA (ACCU + 0),y 
10e0 : 98 __ __ TYA
10e1 : 18 __ __ CLC
10e2 : 69 01 __ ADC #$01
10e4 : a8 __ __ TAY
10e5 : 8a __ __ TXA
10e6 : 69 00 __ ADC #$00
.l5:
10e8 : aa __ __ TAX
10e9 : 18 __ __ CLC
10ea : 69 3f __ ADC #$3f
10ec : 85 1c __ STA ACCU + 1 
10ee : ad 1c df LDA $df1c 
10f1 : 29 40 __ AND #$40
10f3 : d0 e6 __ BNE $10db ; (uci_readstatus.s7 + 0)
.s6:
10f5 : 91 1b __ STA (ACCU + 0),y 
.s3:
10f7 : 60 __ __ RTS
--------------------------------------------------------------------
uci_open_file@proxy: ; uci_open_file@proxy
10f8 : a9 9d __ LDA #$9d
10fa : 85 12 __ STA P5 
10fc : a9 13 __ LDA #$13
10fe : 85 13 __ STA P6 
--------------------------------------------------------------------
uci_open_file: ; uci_open_file(u8,const u8*)->void
; 139, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
1100 : a5 12 __ LDA P5 ; (filename + 0)
1102 : 85 0d __ STA P0 
1104 : 85 47 __ STA T3 + 0 
1106 : a5 13 __ LDA P6 ; (filename + 1)
1108 : 85 0e __ STA P1 
110a : 85 48 __ STA T3 + 1 
110c : 20 81 13 JSR $1381 ; (strlen.s4 + 0)
110f : a5 1b __ LDA ACCU + 0 
1111 : 85 43 __ STA T0 + 0 
1113 : 18 __ __ CLC
1114 : 69 03 __ ADC #$03
1116 : 85 0f __ STA P2 
1118 : 85 1b __ STA ACCU + 0 
111a : a5 1c __ LDA ACCU + 1 
111c : 85 44 __ STA T0 + 1 
111e : 69 00 __ ADC #$00
1120 : 85 10 __ STA P3 
1122 : 85 1c __ STA ACCU + 1 
1124 : 20 29 34 JSR $3429 ; (crt_malloc + 0)
1127 : a9 00 __ LDA #$00
1129 : a8 __ __ TAY
112a : 91 1b __ STA (ACCU + 0),y 
112c : a9 02 __ LDA #$02
112e : c8 __ __ INY
112f : 91 1b __ STA (ACCU + 0),y 
1131 : a5 11 __ LDA P4 ; (attrib + 0)
1133 : c8 __ __ INY
1134 : 91 1b __ STA (ACCU + 0),y 
1136 : a5 44 __ LDA T0 + 1 
1138 : 30 2e __ BMI $1168 ; (uci_open_file.s5 + 0)
.s8:
113a : 05 43 __ ORA T0 + 0 
113c : f0 2a __ BEQ $1168 ; (uci_open_file.s5 + 0)
.s6:
113e : a5 1b __ LDA ACCU + 0 
1140 : 85 45 __ STA T2 + 0 
1142 : a5 1c __ LDA ACCU + 1 
1144 : 85 46 __ STA T2 + 1 
1146 : a6 44 __ LDX T0 + 1 
.l7:
1148 : a0 00 __ LDY #$00
114a : b1 47 __ LDA (T3 + 0),y 
114c : a0 03 __ LDY #$03
114e : 91 45 __ STA (T2 + 0),y 
1150 : e6 45 __ INC T2 + 0 
1152 : d0 02 __ BNE $1156 ; (uci_open_file.s13 + 0)
.s12:
1154 : e6 46 __ INC T2 + 1 
.s13:
1156 : e6 47 __ INC T3 + 0 
1158 : d0 02 __ BNE $115c ; (uci_open_file.s15 + 0)
.s14:
115a : e6 48 __ INC T3 + 1 
.s15:
115c : a5 43 __ LDA T0 + 0 
115e : d0 01 __ BNE $1161 ; (uci_open_file.s10 + 0)
.s9:
1160 : ca __ __ DEX
.s10:
1161 : c6 43 __ DEC T0 + 0 
1163 : d0 e3 __ BNE $1148 ; (uci_open_file.l7 + 0)
.s11:
1165 : 8a __ __ TXA
1166 : d0 e0 __ BNE $1148 ; (uci_open_file.l7 + 0)
.s5:
1168 : a5 1b __ LDA ACCU + 0 
116a : 85 0d __ STA P0 
116c : a5 1c __ LDA ACCU + 1 
116e : 85 0e __ STA P1 
1170 : a9 01 __ LDA #$01
1172 : 8d 41 36 STA $3641 ; (uci_target + 0)
1175 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
1178 : 20 f7 34 JSR $34f7 ; (crt_free@proxy + 0)
117b : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
117e : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
--------------------------------------------------------------------
uci_accept: ; uci_accept()->void
; 122, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
1181 : ad 1c df LDA $df1c 
1184 : 09 02 __ ORA #$02
1186 : 8d 1c df STA $df1c 
.l5:
1189 : ad 1c df LDA $df1c 
118c : 29 02 __ AND #$02
118e : d0 f9 __ BNE $1189 ; (uci_accept.l5 + 0)
.s3:
1190 : 60 __ __ RTS
--------------------------------------------------------------------
1191 : __ __ __ BYT 75 6c 74 69 6d 61 74 65 20 69 69 2b 20 6e 6f 74 : ultimate ii+ not
11a1 : __ __ __ BYT 20 66 6f 75 6e 64 21 00                         :  found!.
--------------------------------------------------------------------
11a9 : __ __ __ BYT 70 72 65 73 73 20 61 6e 79 20 6b 65 79 20 74 6f : press any key to
11b9 : __ __ __ BYT 20 65 78 69 74 00                               :  exit.
--------------------------------------------------------------------
wait_key: ; wait_key()->void
; 519, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.l5:
11bf : 20 d0 11 JSR $11d0 ; (keyb_poll.s4 + 0)
11c2 : 2c f9 36 BIT $36f9 ; (keyb_key + 0)
11c5 : 30 f8 __ BMI $11bf ; (wait_key.l5 + 0)
.l4:
11c7 : 20 d0 11 JSR $11d0 ; (keyb_poll.s4 + 0)
11ca : 2c f9 36 BIT $36f9 ; (keyb_key + 0)
11cd : 10 f8 __ BPL $11c7 ; (wait_key.l4 + 0)
.s3:
11cf : 60 __ __ RTS
--------------------------------------------------------------------
keyb_poll: ; keyb_poll()->void
; 126, "/usr/local/include/oscar64/c64/keyboard.h"
.s4:
11d0 : a9 00 __ LDA #$00
11d2 : 8d f9 36 STA $36f9 ; (keyb_key + 0)
11d5 : a9 ff __ LDA #$ff
11d7 : 8d 02 dc STA $dc02 
11da : 8d 00 dc STA $dc00 
11dd : ae 01 dc LDX $dc01 
11e0 : e8 __ __ INX
11e1 : d0 25 __ BNE $1208 ; (keyb_poll.s3 + 0)
.s5:
11e3 : 8e 03 dc STX $dc03 
11e6 : 8e 00 dc STX $dc00 
11e9 : ad 01 dc LDA $dc01 
11ec : c9 ff __ CMP #$ff
11ee : d0 1f __ BNE $120f ; (keyb_poll.s7 + 0)
.s6:
11f0 : 8d 1c 3e STA $3e1c ; (keyb_matrix[0] + 0)
11f3 : 8d 1d 3e STA $3e1d ; (keyb_matrix[0] + 1)
11f6 : 8d 1e 3e STA $3e1e ; (keyb_matrix[0] + 2)
11f9 : 8d 1f 3e STA $3e1f ; (keyb_matrix[0] + 3)
11fc : 8d 20 3e STA $3e20 ; (keyb_matrix[0] + 4)
11ff : 8d 21 3e STA $3e21 ; (keyb_matrix[0] + 5)
1202 : 8d 22 3e STA $3e22 ; (keyb_matrix[0] + 6)
1205 : 8d 23 3e STA $3e23 ; (keyb_matrix[0] + 7)
.s3:
1208 : ad fa 36 LDA $36fa ; (ciaa_pra_def + 0)
120b : 8d 00 dc STA $dc00 
120e : 60 __ __ RTS
.s7:
120f : ad 22 3e LDA $3e22 ; (keyb_matrix[0] + 6)
1212 : 29 ef __ AND #$ef
1214 : 8d 22 3e STA $3e22 ; (keyb_matrix[0] + 6)
1217 : ad 1d 3e LDA $3e1d ; (keyb_matrix[0] + 1)
121a : 29 7f __ AND #$7f
121c : 8d 1d 3e STA $3e1d ; (keyb_matrix[0] + 1)
121f : a9 fe __ LDA #$fe
1221 : 85 1b __ STA ACCU + 0 
.l20:
1223 : a5 1b __ LDA ACCU + 0 
1225 : 8d 00 dc STA $dc00 
1228 : bd 1c 3e LDA $3e1c,x ; (keyb_matrix[0] + 0)
122b : 85 1c __ STA ACCU + 1 
122d : ad 01 dc LDA $dc01 
1230 : 9d 1c 3e STA $3e1c,x ; (keyb_matrix[0] + 0)
1233 : 38 __ __ SEC
1234 : 26 1b __ ROL ACCU + 0 
1236 : 49 ff __ EOR #$ff
1238 : 25 1c __ AND ACCU + 1 
123a : f0 25 __ BEQ $1261 ; (keyb_poll.s8 + 0)
.s13:
123c : 85 1c __ STA ACCU + 1 
123e : 8a __ __ TXA
123f : 0a __ __ ASL
1240 : 0a __ __ ASL
1241 : 0a __ __ ASL
1242 : 09 80 __ ORA #$80
1244 : a8 __ __ TAY
1245 : a5 1c __ LDA ACCU + 1 
1247 : 29 f0 __ AND #$f0
1249 : f0 04 __ BEQ $124f ; (keyb_poll.s14 + 0)
.s19:
124b : 98 __ __ TYA
124c : 09 04 __ ORA #$04
124e : a8 __ __ TAY
.s14:
124f : a5 1c __ LDA ACCU + 1 
1251 : 29 cc __ AND #$cc
1253 : f0 02 __ BEQ $1257 ; (keyb_poll.s15 + 0)
.s18:
1255 : c8 __ __ INY
1256 : c8 __ __ INY
.s15:
1257 : a5 1c __ LDA ACCU + 1 
1259 : 29 aa __ AND #$aa
125b : f0 01 __ BEQ $125e ; (keyb_poll.s16 + 0)
.s17:
125d : c8 __ __ INY
.s16:
125e : 8c f9 36 STY $36f9 ; (keyb_key + 0)
.s8:
1261 : e8 __ __ INX
1262 : e0 08 __ CPX #$08
1264 : 90 bd __ BCC $1223 ; (keyb_poll.l20 + 0)
.s9:
1266 : ad f9 36 LDA $36f9 ; (keyb_key + 0)
1269 : f0 9d __ BEQ $1208 ; (keyb_poll.s3 + 0)
.s10:
126b : 2c 1d 3e BIT $3e1d ; (keyb_matrix[0] + 1)
126e : 10 07 __ BPL $1277 ; (keyb_poll.s11 + 0)
.s12:
1270 : ad 22 3e LDA $3e22 ; (keyb_matrix[0] + 6)
1273 : 29 10 __ AND #$10
1275 : d0 91 __ BNE $1208 ; (keyb_poll.s3 + 0)
.s11:
1277 : ad f9 36 LDA $36f9 ; (keyb_key + 0)
127a : 09 40 __ ORA #$40
127c : 8d f9 36 STA $36f9 ; (keyb_key + 0)
127f : b0 87 __ BCS $1208 ; (keyb_poll.s3 + 0)
--------------------------------------------------------------------
1281 : __ __ __ BYT 75 6c 74 69 6d 61 74 65 20 69 69 2b 20 64 65 74 : ultimate ii+ det
1291 : __ __ __ BYT 65 63 74 65 64 00                               : ected.
--------------------------------------------------------------------
1297 : __ __ __ BYT 6c 6f 61 64 69 6e 67 20 73 65 74 74 69 6e 67 73 : loading settings
12a7 : __ __ __ BYT 2e 2e 2e 00                                     : ....
--------------------------------------------------------------------
load_settings: ; load_settings()->void
; 128, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
12ab : a9 01 __ LDA #$01
12ad : 85 11 __ STA P4 
12af : 8d 41 36 STA $3641 ; (uci_target + 0)
12b2 : 20 f8 10 JSR $10f8 ; (uci_open_file@proxy + 0)
12b5 : ad 00 3f LDA $3f00 ; (uci_status[0] + 0)
12b8 : c9 30 __ CMP #$30
12ba : d0 07 __ BNE $12c3 ; (load_settings.s3 + 0)
.s5:
12bc : ad 01 3f LDA $3f01 ; (uci_status[0] + 1)
12bf : c9 30 __ CMP #$30
12c1 : f0 01 __ BEQ $12c4 ; (load_settings.s6 + 0)
.s3:
12c3 : 60 __ __ RTS
.s6:
12c4 : a9 00 __ LDA #$00
12c6 : 85 10 __ STA P3 
12c8 : 8d f0 9f STA $9ff0 ; (cmd[0] + 0)
12cb : 8d f2 9f STA $9ff2 ; (cmd[0] + 2)
12ce : 8d f3 9f STA $9ff3 ; (cmd[0] + 3)
12d1 : a9 01 __ LDA #$01
12d3 : 8d 41 36 STA $3641 ; (uci_target + 0)
12d6 : a9 04 __ LDA #$04
12d8 : 85 0f __ STA P2 
12da : 8d f1 9f STA $9ff1 ; (cmd[0] + 1)
12dd : a9 1f __ LDA #$1f
12df : 8d f2 9f STA $9ff2 ; (cmd[0] + 2)
12e2 : a9 00 __ LDA #$00
12e4 : 8d f3 9f STA $9ff3 ; (cmd[0] + 3)
12e7 : a9 f0 __ LDA #$f0
12e9 : 85 0d __ STA P0 
12eb : a9 9f __ LDA #$9f
12ed : 85 0e __ STA P1 
12ef : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
12f2 : a9 03 __ LDA #$03
12f4 : a0 e8 __ LDY #$e8
12f6 : d0 09 __ BNE $1301 ; (load_settings.l7 + 0)
.s19:
12f8 : 98 __ __ TYA
12f9 : 18 __ __ CLC
12fa : 69 ff __ ADC #$ff
12fc : a8 __ __ TAY
12fd : a5 44 __ LDA T0 + 1 
12ff : 69 ff __ ADC #$ff
.l7:
1301 : 2c 1c df BIT $df1c 
1304 : 30 07 __ BMI $130d ; (load_settings.s9 + 0)
.s8:
1306 : 85 44 __ STA T0 + 1 
1308 : 98 __ __ TYA
1309 : 05 44 __ ORA T0 + 1 
130b : d0 eb __ BNE $12f8 ; (load_settings.s19 + 0)
.s9:
130d : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
1310 : a5 1b __ LDA ACCU + 0 
1312 : 85 49 __ STA T2 + 0 
1314 : a5 1c __ LDA ACCU + 1 
1316 : 85 4a __ STA T2 + 1 
1318 : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
131b : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
131e : a5 4a __ LDA T2 + 1 
1320 : 30 2e __ BMI $1350 ; (uci_close_file.s4 + 0)
.s18:
1322 : 05 49 __ ORA T2 + 0 
1324 : f0 2a __ BEQ $1350 ; (uci_close_file.s4 + 0)
.s10:
1326 : a0 00 __ LDY #$00
1328 : a6 4a __ LDX T2 + 1 
132a : ad 1c 37 LDA $371c ; (uci_data[0] + 0)
132d : f0 1c __ BEQ $134b ; (load_settings.s12 + 0)
.l13:
132f : c9 0a __ CMP #$0a
1331 : f0 18 __ BEQ $134b ; (load_settings.s12 + 0)
.s14:
1333 : c9 0d __ CMP #$0d
1335 : f0 14 __ BEQ $134b ; (load_settings.s12 + 0)
.s15:
1337 : 99 42 36 STA $3642,y ; (server_host[0] + 0)
133a : c8 __ __ INY
133b : c0 1f __ CPY #$1f
133d : b0 0c __ BCS $134b ; (load_settings.s12 + 0)
.s16:
133f : 8a __ __ TXA
1340 : d0 04 __ BNE $1346 ; (load_settings.s11 + 0)
.s17:
1342 : c4 49 __ CPY T2 + 0 
1344 : b0 05 __ BCS $134b ; (load_settings.s12 + 0)
.s11:
1346 : b9 1c 37 LDA $371c,y ; (uci_data[0] + 0)
1349 : d0 e4 __ BNE $132f ; (load_settings.l13 + 0)
.s12:
134b : a9 00 __ LDA #$00
134d : 99 42 36 STA $3642,y ; (server_host[0] + 0)
--------------------------------------------------------------------
uci_close_file: ; uci_close_file()->void
; 140, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
1350 : a9 00 __ LDA #$00
1352 : 85 10 __ STA P3 
1354 : 8d f4 9f STA $9ff4 ; (cmd[0] + 0)
1357 : a9 02 __ LDA #$02
1359 : 85 0f __ STA P2 
135b : a9 01 __ LDA #$01
135d : 8d 41 36 STA $3641 ; (uci_target + 0)
1360 : a9 03 __ LDA #$03
1362 : 8d f5 9f STA $9ff5 ; (cmd[0] + 1)
1365 : a9 f4 __ LDA #$f4
1367 : 85 0d __ STA P0 
1369 : a9 9f __ LDA #$9f
136b : 85 0e __ STA P1 
136d : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
1370 : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
1373 : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
1376 : 4c 81 11 JMP $1181 ; (uci_accept.s4 + 0)
--------------------------------------------------------------------
strlen@proxy: ; strlen@proxy
1379 : a9 42 __ LDA #$42
137b : 85 0d __ STA P0 
137d : a9 36 __ LDA #$36
137f : 85 0e __ STA P1 
--------------------------------------------------------------------
strlen: ; strlen(const u8*)->i16
;  12, "/usr/local/include/oscar64/string.h"
.s4:
1381 : a9 00 __ LDA #$00
1383 : 85 1b __ STA ACCU + 0 
1385 : 85 1c __ STA ACCU + 1 
1387 : a8 __ __ TAY
1388 : b1 0d __ LDA (P0),y ; (str + 0)
138a : f0 10 __ BEQ $139c ; (strlen.s3 + 0)
.s6:
138c : a2 00 __ LDX #$00
.l7:
138e : c8 __ __ INY
138f : d0 03 __ BNE $1394 ; (strlen.s9 + 0)
.s8:
1391 : e6 0e __ INC P1 ; (str + 1)
1393 : e8 __ __ INX
.s9:
1394 : b1 0d __ LDA (P0),y ; (str + 0)
1396 : d0 f6 __ BNE $138e ; (strlen.l7 + 0)
.s5:
1398 : 86 1c __ STX ACCU + 1 
139a : 84 1b __ STY ACCU + 0 
.s3:
139c : 60 __ __ RTS
--------------------------------------------------------------------
139d : __ __ __ BYT 2f 55 73 62 31 2f 61 36 34 62 72 6f 77 73 65 72 : /Usb1/a64browser
13ad : __ __ __ BYT 2e 63 66 67 00                                  : .cfg.
--------------------------------------------------------------------
13b2 : __ __ __ BYT 73 65 72 76 65 72 3a 20 00                      : server: .
--------------------------------------------------------------------
13bb : __ __ __ BYT 67 65 74 74 69 6e 67 20 69 70 20 61 64 64 72 65 : getting ip addre
13cb : __ __ __ BYT 73 73 2e 2e 2e 00                               : ss....
--------------------------------------------------------------------
uci_getipaddress: ; uci_getipaddress()->void
; 154, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
13d1 : a9 00 __ LDA #$00
13d3 : 8d f5 9f STA $9ff5 ; (cmd[0] + 2)
13d6 : 85 10 __ STA P3 
13d8 : 8d f3 9f STA $9ff3 ; (cmd[0] + 0)
13db : a9 05 __ LDA #$05
13dd : 8d f4 9f STA $9ff4 ; (cmd[0] + 1)
13e0 : ad 41 36 LDA $3641 ; (uci_target + 0)
13e3 : 85 45 __ STA T1 + 0 
13e5 : a9 03 __ LDA #$03
13e7 : 85 0f __ STA P2 
13e9 : 8d 41 36 STA $3641 ; (uci_target + 0)
13ec : a9 f3 __ LDA #$f3
13ee : 85 0d __ STA P0 
13f0 : a9 9f __ LDA #$9f
13f2 : 85 0e __ STA P1 
13f4 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
13f7 : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
13fa : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
13fd : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
1400 : a5 45 __ LDA T1 + 0 
1402 : 8d 41 36 STA $3641 ; (uci_target + 0)
.s3:
1405 : 60 __ __ RTS
--------------------------------------------------------------------
1406 : __ __ __ BYT 69 70 3a 20 00                                  : ip: .
--------------------------------------------------------------------
140b : __ __ __ BYT 63 3d 63 6f 6e 66 69 67 2c 20 61 6e 79 20 6f 74 : c=config, any ot
141b : __ __ __ BYT 68 65 72 20 6b 65 79 3d 63 6f 6e 6e 65 63 74 00 : her key=connect.
--------------------------------------------------------------------
draw_settings: ; draw_settings()->void
; 605, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
142b : a9 00 __ LDA #$00
142d : 85 0d __ STA P0 
142f : 85 0e __ STA P1 
1431 : 20 27 0f JSR $0f27 ; (clear_screen@proxy + 0)
1434 : a9 99 __ LDA #$99
1436 : 85 0f __ STA P2 
1438 : a9 15 __ LDA #$15
143a : 85 10 __ STA P3 
143c : 20 15 15 JSR $1515 ; (print_at_color.s4 + 0)
143f : a9 04 __ LDA #$04
1441 : 85 0e __ STA P1 
1443 : ad 64 36 LDA $3664 ; (settings_cursor + 0)
1446 : 85 47 __ STA T2 + 0 
1448 : ae 65 36 LDX $3665 ; (settings_cursor + 1)
144b : 0d 65 36 ORA $3665 ; (settings_cursor + 1)
144e : f0 5a __ BEQ $14aa ; (draw_settings.s13 + 0)
.s5:
1450 : 86 48 __ STX T2 + 1 
1452 : a9 0e __ LDA #$0e
1454 : 85 11 __ STA P4 
1456 : 20 31 36 JSR $3631 ; (print_at_color@proxy + 0)
1459 : a9 0a __ LDA #$0a
145b : 85 0d __ STA P0 
145d : a9 36 __ LDA #$36
145f : 85 10 __ STA P3 
1461 : a9 42 __ LDA #$42
1463 : 85 0f __ STA P2 
1465 : 20 15 15 JSR $1515 ; (print_at_color.s4 + 0)
1468 : a5 48 __ LDA T2 + 1 
146a : d0 05 __ BNE $1471 ; (draw_settings.s6 + 0)
.s12:
146c : a6 47 __ LDX T2 + 0 
146e : ca __ __ DEX
146f : f0 06 __ BEQ $1477 ; (draw_settings.s11 + 0)
.s6:
1471 : a9 0e __ LDA #$0e
1473 : 85 11 __ STA P4 
1475 : d0 09 __ BNE $1480 ; (draw_settings.s7 + 0)
.s11:
1477 : 85 0d __ STA P0 
1479 : a9 06 __ LDA #$06
147b : 85 0e __ STA P1 
147d : 20 22 36 JSR $3622 ; (print_at_color@proxy + 0)
.s7:
1480 : a9 15 __ LDA #$15
1482 : 85 10 __ STA P3 
1484 : a9 06 __ LDA #$06
1486 : 85 0e __ STA P1 
1488 : a9 ae __ LDA #$ae
148a : 85 0f __ STA P2 
148c : 20 08 36 JSR $3608 ; (print_at_color@proxy + 0)
148f : ad 66 36 LDA $3666 ; (settings_editing + 0)
1492 : d0 07 __ BNE $149b ; (draw_settings.s10 + 0)
.s8:
1494 : a9 15 __ LDA #$15
1496 : a0 d4 __ LDY #$d4
1498 : 4c 9f 14 JMP $149f ; (draw_settings.s9 + 0)
.s10:
149b : a9 15 __ LDA #$15
149d : a0 b5 __ LDY #$b5
.s9:
149f : 84 0f __ STY P2 
14a1 : 85 10 __ STA P3 
14a3 : a9 17 __ LDA #$17
14a5 : 85 0e __ STA P1 
14a7 : 4c dc 35 JMP $35dc ; (print_at@proxy + 0)
.s13:
14aa : 20 22 36 JSR $3622 ; (print_at_color@proxy + 0)
14ad : 20 31 36 JSR $3631 ; (print_at_color@proxy + 0)
14b0 : a9 0a __ LDA #$0a
14b2 : 85 0d __ STA P0 
14b4 : a9 42 __ LDA #$42
14b6 : 85 0f __ STA P2 
14b8 : a9 36 __ LDA #$36
14ba : 85 10 __ STA P3 
14bc : ad 66 36 LDA $3666 ; (settings_editing + 0)
14bf : f0 17 __ BEQ $14d8 ; (draw_settings.s14 + 0)
.s15:
14c1 : a9 05 __ LDA #$05
14c3 : 85 11 __ STA P4 
14c5 : 20 15 15 JSR $1515 ; (print_at_color.s4 + 0)
14c8 : ad 67 36 LDA $3667 ; (settings_edit_pos + 0)
14cb : 18 __ __ CLC
14cc : 69 0a __ ADC #$0a
14ce : 85 0d __ STA P0 
14d0 : a9 ac __ LDA #$ac
14d2 : 85 0f __ STA P2 
14d4 : a9 15 __ LDA #$15
14d6 : 85 10 __ STA P3 
.s14:
14d8 : 20 15 15 JSR $1515 ; (print_at_color.s4 + 0)
14db : 4c 71 14 JMP $1471 ; (draw_settings.s6 + 0)
--------------------------------------------------------------------
draw_item: ; draw_item(i16,bool)->void
; 533, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
14de : 18 __ __ CLC
14df : a5 14 __ LDA P7 ; (i + 0)
14e1 : 69 04 __ ADC #$04
14e3 : 85 13 __ STA P6 
14e5 : 20 fd 21 JSR $21fd ; (clear_line.s4 + 0)
14e8 : a5 13 __ LDA P6 
14ea : 85 0e __ STA P1 
14ec : a5 16 __ LDA P9 ; (selected + 0)
14ee : d0 06 __ BNE $14f6 ; (draw_item.s7 + 0)
.s5:
14f0 : a9 0e __ LDA #$0e
14f2 : 85 11 __ STA P4 
14f4 : d0 03 __ BNE $14f9 ; (draw_item.s6 + 0)
.s7:
14f6 : 20 0f 36 JSR $360f ; (print_at_color@proxy + 0)
.s6:
14f9 : a5 15 __ LDA P8 ; (i + 1)
14fb : 4a __ __ LSR
14fc : 66 14 __ ROR P7 ; (i + 0)
14fe : 6a __ __ ROR
14ff : 66 14 __ ROR P7 ; (i + 0)
1501 : 6a __ __ ROR
1502 : 66 14 __ ROR P7 ; (i + 0)
1504 : 29 c0 __ AND #$c0
1506 : 6a __ __ ROR
1507 : 69 00 __ ADC #$00
1509 : 85 0f __ STA P2 
150b : a9 02 __ LDA #$02
150d : 85 0d __ STA P0 
150f : a9 40 __ LDA #$40
1511 : 65 14 __ ADC P7 ; (i + 0)
1513 : 85 10 __ STA P3 
--------------------------------------------------------------------
print_at_color: ; print_at_color(u8,u8,const u8*,u8)->void
;  95, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
1515 : a5 0e __ LDA P1 ; (y + 0)
1517 : 0a __ __ ASL
1518 : 85 1b __ STA ACCU + 0 
151a : a9 00 __ LDA #$00
151c : 2a __ __ ROL
151d : 06 1b __ ASL ACCU + 0 
151f : 2a __ __ ROL
1520 : aa __ __ TAX
1521 : a5 1b __ LDA ACCU + 0 
1523 : 65 0e __ ADC P1 ; (y + 0)
1525 : 85 43 __ STA T1 + 0 
1527 : 8a __ __ TXA
1528 : 69 00 __ ADC #$00
152a : 06 43 __ ASL T1 + 0 
152c : 2a __ __ ROL
152d : 06 43 __ ASL T1 + 0 
152f : 2a __ __ ROL
1530 : 06 43 __ ASL T1 + 0 
1532 : 2a __ __ ROL
1533 : aa __ __ TAX
1534 : a5 43 __ LDA T1 + 0 
1536 : 65 0d __ ADC P0 ; (x + 0)
1538 : 85 45 __ STA T2 + 0 
153a : 85 43 __ STA T1 + 0 
153c : 8a __ __ TXA
153d : 69 04 __ ADC #$04
153f : 85 46 __ STA T2 + 1 
1541 : 69 d4 __ ADC #$d4
1543 : 85 44 __ STA T1 + 1 
1545 : a0 00 __ LDY #$00
1547 : b1 0f __ LDA (P2),y ; (text + 0)
1549 : f0 4d __ BEQ $1598 ; (print_at_color.s3 + 0)
.s14:
154b : a6 0f __ LDX P2 ; (text + 0)
.l5:
154d : 86 1b __ STX ACCU + 0 
154f : 8a __ __ TXA
1550 : 18 __ __ CLC
1551 : 69 01 __ ADC #$01
1553 : aa __ __ TAX
1554 : a5 10 __ LDA P3 ; (text + 1)
1556 : 85 1c __ STA ACCU + 1 
1558 : 69 00 __ ADC #$00
155a : 85 10 __ STA P3 ; (text + 1)
155c : a0 00 __ LDY #$00
155e : b1 1b __ LDA (ACCU + 0),y 
1560 : c9 61 __ CMP #$61
1562 : 90 09 __ BCC $156d ; (print_at_color.s6 + 0)
.s11:
1564 : c9 7b __ CMP #$7b
1566 : b0 05 __ BCS $156d ; (print_at_color.s6 + 0)
.s12:
1568 : 69 a0 __ ADC #$a0
156a : 4c 80 15 JMP $1580 ; (print_at_color.s13 + 0)
.s6:
156d : c9 41 __ CMP #$41
156f : 90 0f __ BCC $1580 ; (print_at_color.s13 + 0)
.s7:
1571 : c9 5b __ CMP #$5b
1573 : b0 05 __ BCS $157a ; (print_at_color.s8 + 0)
.s10:
1575 : 69 c0 __ ADC #$c0
1577 : 4c 80 15 JMP $1580 ; (print_at_color.s13 + 0)
.s8:
157a : c9 7c __ CMP #$7c
157c : d0 02 __ BNE $1580 ; (print_at_color.s13 + 0)
.s9:
157e : a9 20 __ LDA #$20
.s13:
1580 : 91 45 __ STA (T2 + 0),y 
1582 : a5 11 __ LDA P4 ; (color + 0)
1584 : 91 43 __ STA (T1 + 0),y 
1586 : e6 45 __ INC T2 + 0 
1588 : d0 02 __ BNE $158c ; (print_at_color.s16 + 0)
.s15:
158a : e6 46 __ INC T2 + 1 
.s16:
158c : e6 43 __ INC T1 + 0 
158e : d0 02 __ BNE $1592 ; (print_at_color.s18 + 0)
.s17:
1590 : e6 44 __ INC T1 + 1 
.s18:
1592 : a0 01 __ LDY #$01
1594 : b1 1b __ LDA (ACCU + 0),y 
1596 : d0 b5 __ BNE $154d ; (print_at_color.l5 + 0)
.s3:
1598 : 60 __ __ RTS
--------------------------------------------------------------------
1599 : __ __ __ BYT 73 65 74 74 69 6e 67 73 00                      : settings.
--------------------------------------------------------------------
15a2 : __ __ __ BYT 3e 00                                           : >.
--------------------------------------------------------------------
15a4 : __ __ __ BYT 73 65 72 76 65 72 3a 00                         : server:.
--------------------------------------------------------------------
15ac : __ __ __ BYT 5f 00                                           : _.
--------------------------------------------------------------------
15ae : __ __ __ BYT 5b 73 61 76 65 5d 00                            : [save].
--------------------------------------------------------------------
15b5 : __ __ __ BYT 74 79 70 65 20 69 70 20 20 65 6e 74 65 72 3a 64 : type ip  enter:d
15c5 : __ __ __ BYT 6f 6e 65 20 20 64 65 6c 3a 65 72 61 73 65 00    : one  del:erase.
--------------------------------------------------------------------
15d4 : __ __ __ BYT 77 2f 73 3a 6d 6f 76 65 20 65 6e 74 65 72 3a 65 : w/s:move enter:e
15e4 : __ __ __ BYT 64 69 74 2f 73 61 76 65 20 64 65 6c 3a 62 61 63 : dit/save del:bac
15f4 : __ __ __ BYT 6b 00                                           : k.
--------------------------------------------------------------------
get_key: ; get_key()->u8
; 429, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
15f6 : a5 53 __ LDA T1 + 0 
15f8 : 8d b5 9f STA $9fb5 ; (get_key@stack + 0)
15fb : a5 54 __ LDA T3 + 0 
15fd : 8d b6 9f STA $9fb6 ; (get_key@stack + 1)
.s4:
1600 : 20 d0 11 JSR $11d0 ; (keyb_poll.s4 + 0)
1603 : ad f9 36 LDA $36f9 ; (keyb_key + 0)
1606 : 10 72 __ BPL $167a ; (get_key.s60 + 0)
.s5:
1608 : 29 40 __ AND #$40
160a : f0 02 __ BEQ $160e ; (get_key.s57 + 0)
.s56:
160c : a9 01 __ LDA #$01
.s57:
160e : 85 54 __ STA T3 + 0 
1610 : 8d fe 9f STA $9ffe ; (sstack + 8)
1613 : ad f9 36 LDA $36f9 ; (keyb_key + 0)
1616 : 29 3f __ AND #$3f
1618 : 85 53 __ STA T1 + 0 
161a : 85 18 __ STA P11 
161c : 20 52 0f JSR $0f52 ; (debug_key.s4 + 0)
161f : a5 53 __ LDA T1 + 0 
1621 : c9 01 __ CMP #$01
1623 : d0 0f __ BNE $1634 ; (get_key.s6 + 0)
.s55:
1625 : a9 0d __ LDA #$0d
.s3:
1627 : 85 1b __ STA ACCU + 0 
1629 : ad b5 9f LDA $9fb5 ; (get_key@stack + 0)
162c : 85 53 __ STA T1 + 0 
162e : ad b6 9f LDA $9fb6 ; (get_key@stack + 1)
1631 : 85 54 __ STA T3 + 0 
1633 : 60 __ __ RTS
.s6:
1634 : aa __ __ TAX
1635 : f0 3f __ BEQ $1676 ; (get_key.s61 + 0)
.s7:
1637 : ad 62 36 LDA $3662 ; (current_page + 0)
163a : a8 __ __ TAY
163b : 0d 63 36 ORA $3663 ; (current_page + 1)
163e : d0 03 __ BNE $1643 ; (get_key.s8 + 0)
1640 : 4c 0f 17 JMP $170f ; (get_key.s44 + 0)
.s8:
1643 : ad 63 36 LDA $3663 ; (current_page + 1)
1646 : d0 32 __ BNE $167a ; (get_key.s60 + 0)
.s43:
1648 : c0 01 __ CPY #$01
164a : d0 03 __ BNE $164f ; (get_key.s35 + 0)
164c : 4c e9 16 JMP $16e9 ; (get_key.s36 + 0)
.s35:
164f : c0 02 __ CPY #$02
1651 : f0 52 __ BEQ $16a5 ; (get_key.s22 + 0)
.s21:
1653 : c0 03 __ CPY #$03
1655 : d0 23 __ BNE $167a ; (get_key.s60 + 0)
.s9:
1657 : ad 66 36 LDA $3666 ; (settings_editing + 0)
165a : d0 2a __ BNE $1686 ; (get_key.s16 + 0)
.s10:
165c : a5 53 __ LDA T1 + 0 
165e : c9 09 __ CMP #$09
1660 : f0 20 __ BEQ $1682 ; (get_key.s62 + 0)
.s11:
1662 : c9 07 __ CMP #$07
1664 : f0 18 __ BEQ $167e ; (get_key.s15 + 0)
.s12:
1666 : c9 0d __ CMP #$0d
1668 : d0 04 __ BNE $166e ; (get_key.s13 + 0)
.s58:
166a : a9 64 __ LDA #$64
166c : d0 b9 __ BNE $1627 ; (get_key.s3 + 0)
.s13:
166e : c9 02 __ CMP #$02
1670 : d0 08 __ BNE $167a ; (get_key.s60 + 0)
.s14:
1672 : a5 54 __ LDA T3 + 0 
1674 : f0 b1 __ BEQ $1627 ; (get_key.s3 + 0)
.s61:
1676 : a9 08 __ LDA #$08
1678 : d0 ad __ BNE $1627 ; (get_key.s3 + 0)
.s60:
167a : a9 00 __ LDA #$00
167c : f0 a9 __ BEQ $1627 ; (get_key.s3 + 0)
.s15:
167e : a5 54 __ LDA T3 + 0 
1680 : f0 e8 __ BEQ $166a ; (get_key.s58 + 0)
.s62:
1682 : a9 75 __ LDA #$75
1684 : d0 a1 __ BNE $1627 ; (get_key.s3 + 0)
.s16:
1686 : a5 54 __ LDA T3 + 0 
1688 : f0 06 __ BEQ $1690 ; (get_key.s17 + 0)
.s20:
168a : a5 53 __ LDA T1 + 0 
168c : 09 40 __ ORA #$40
168e : 85 53 __ STA T1 + 0 
.s17:
1690 : a6 53 __ LDX T1 + 0 
1692 : bd 69 36 LDA $3669,x ; (keyb_codes[0] + 0)
1695 : c9 30 __ CMP #$30
1697 : b0 06 __ BCS $169f ; (get_key.s19 + 0)
.s18:
1699 : c9 2e __ CMP #$2e
169b : d0 dd __ BNE $167a ; (get_key.s60 + 0)
169d : f0 88 __ BEQ $1627 ; (get_key.s3 + 0)
.s19:
169f : c9 3a __ CMP #$3a
16a1 : b0 d7 __ BCS $167a ; (get_key.s60 + 0)
16a3 : 90 82 __ BCC $1627 ; (get_key.s3 + 0)
.s22:
16a5 : a5 53 __ LDA T1 + 0 
16a7 : c9 02 __ CMP #$02
16a9 : d0 04 __ BNE $16af ; (get_key.s23 + 0)
.s34:
16ab : a5 54 __ LDA T3 + 0 
16ad : d0 c7 __ BNE $1676 ; (get_key.s61 + 0)
.s23:
16af : ad ea 36 LDA $36ea ; (item_count + 1)
16b2 : 30 0b __ BMI $16bf ; (get_key.s24 + 0)
.s33:
16b4 : 0d e9 36 ORA $36e9 ; (item_count + 0)
16b7 : f0 06 __ BEQ $16bf ; (get_key.s24 + 0)
.s32:
16b9 : a5 53 __ LDA T1 + 0 
16bb : c9 07 __ CMP #$07
16bd : f0 bf __ BEQ $167e ; (get_key.s15 + 0)
.s24:
16bf : a5 54 __ LDA T3 + 0 
16c1 : f0 06 __ BEQ $16c9 ; (get_key.s25 + 0)
.s31:
16c3 : a5 53 __ LDA T1 + 0 
16c5 : 09 40 __ ORA #$40
16c7 : 85 53 __ STA T1 + 0 
.s25:
16c9 : a6 53 __ LDX T1 + 0 
16cb : bd 69 36 LDA $3669,x ; (keyb_codes[0] + 0)
16ce : c9 61 __ CMP #$61
16d0 : 90 09 __ BCC $16db ; (get_key.s26 + 0)
.s29:
16d2 : c9 7b __ CMP #$7b
16d4 : b0 05 __ BCS $16db ; (get_key.s26 + 0)
.s30:
16d6 : e9 1f __ SBC #$1f
16d8 : 4c 27 16 JMP $1627 ; (get_key.s3 + 0)
.s26:
16db : c9 41 __ CMP #$41
16dd : 90 04 __ BCC $16e3 ; (get_key.s27 + 0)
.s28:
16df : c9 5b __ CMP #$5b
16e1 : 90 f5 __ BCC $16d8 ; (get_key.s30 + 2)
.s27:
16e3 : c9 30 __ CMP #$30
16e5 : b0 b8 __ BCS $169f ; (get_key.s19 + 0)
16e7 : 90 91 __ BCC $167a ; (get_key.s60 + 0)
.s36:
16e9 : a5 53 __ LDA T1 + 0 
16eb : c9 09 __ CMP #$09
16ed : f0 93 __ BEQ $1682 ; (get_key.s62 + 0)
.s37:
16ef : c9 07 __ CMP #$07
16f1 : f0 8b __ BEQ $167e ; (get_key.s15 + 0)
.s38:
16f3 : c9 0d __ CMP #$0d
16f5 : d0 03 __ BNE $16fa ; (get_key.s39 + 0)
16f7 : 4c 6a 16 JMP $166a ; (get_key.s58 + 0)
.s39:
16fa : c9 27 __ CMP #$27
16fc : d0 05 __ BNE $1703 ; (get_key.s40 + 0)
.s42:
16fe : a9 6e __ LDA #$6e
1700 : 4c 27 16 JMP $1627 ; (get_key.s3 + 0)
.s40:
1703 : c9 29 __ CMP #$29
1705 : f0 03 __ BEQ $170a ; (get_key.s41 + 0)
1707 : 4c 6e 16 JMP $166e ; (get_key.s13 + 0)
.s41:
170a : a9 70 __ LDA #$70
170c : 4c 27 16 JMP $1627 ; (get_key.s3 + 0)
.s44:
170f : a5 53 __ LDA T1 + 0 
1711 : c9 3e __ CMP #$3e
1713 : d0 05 __ BNE $171a ; (get_key.s45 + 0)
.s54:
1715 : a9 71 __ LDA #$71
1717 : 4c 27 16 JMP $1627 ; (get_key.s3 + 0)
.s45:
171a : c9 14 __ CMP #$14
171c : d0 05 __ BNE $1723 ; (get_key.s46 + 0)
.s53:
171e : a9 63 __ LDA #$63
1720 : 4c 27 16 JMP $1627 ; (get_key.s3 + 0)
.s46:
1723 : c9 09 __ CMP #$09
1725 : d0 03 __ BNE $172a ; (get_key.s47 + 0)
1727 : 4c 82 16 JMP $1682 ; (get_key.s62 + 0)
.s47:
172a : c9 07 __ CMP #$07
172c : d0 03 __ BNE $1731 ; (get_key.s48 + 0)
172e : 4c 7e 16 JMP $167e ; (get_key.s15 + 0)
.s48:
1731 : c9 0d __ CMP #$0d
1733 : f0 c2 __ BEQ $16f7 ; (get_key.s38 + 4)
.s49:
1735 : c9 37 __ CMP #$37
1737 : d0 05 __ BNE $173e ; (get_key.s50 + 0)
.s52:
1739 : a9 2f __ LDA #$2f
173b : 4c 27 16 JMP $1627 ; (get_key.s3 + 0)
.s50:
173e : c9 02 __ CMP #$02
1740 : f0 03 __ BEQ $1745 ; (get_key.s51 + 0)
1742 : 4c 7a 16 JMP $167a ; (get_key.s60 + 0)
.s51:
1745 : a5 54 __ LDA T3 + 0 
1747 : d0 f9 __ BNE $1742 ; (get_key.s50 + 4)
.s59:
1749 : a9 3e __ LDA #$3e
174b : 4c 27 16 JMP $1627 ; (get_key.s3 + 0)
--------------------------------------------------------------------
sprintf: ; sprintf(u8*,const u8*)->void
;  20, "/usr/local/include/oscar64/stdio.h"
.s1:
174e : a2 03 __ LDX #$03
1750 : b5 53 __ LDA T3 + 0,x 
1752 : 9d d8 9f STA $9fd8,x ; (sprintf@stack + 0)
1755 : ca __ __ DEX
1756 : 10 f8 __ BPL $1750 ; (sprintf.s1 + 2)
.s4:
1758 : ad f6 9f LDA $9ff6 ; (sstack + 0)
175b : 85 55 __ STA T4 + 0 
175d : a9 f8 __ LDA #$f8
175f : 85 53 __ STA T3 + 0 
1761 : a9 9f __ LDA #$9f
1763 : 85 54 __ STA T3 + 1 
1765 : a9 00 __ LDA #$00
1767 : 85 49 __ STA T2 + 0 
1769 : ad f7 9f LDA $9ff7 ; (sstack + 1)
176c : 85 56 __ STA T4 + 1 
.l5:
176e : a0 00 __ LDY #$00
1770 : b1 55 __ LDA (T4 + 0),y 
1772 : d0 0f __ BNE $1783 ; (sprintf.s7 + 0)
.s6:
1774 : a4 49 __ LDY T2 + 0 
1776 : 91 16 __ STA (P9),y ; (str + 0)
.s3:
1778 : a2 03 __ LDX #$03
177a : bd d8 9f LDA $9fd8,x ; (sprintf@stack + 0)
177d : 95 53 __ STA T3 + 0,x 
177f : ca __ __ DEX
1780 : 10 f8 __ BPL $177a ; (sprintf.s3 + 2)
1782 : 60 __ __ RTS
.s7:
1783 : c9 25 __ CMP #$25
1785 : f0 22 __ BEQ $17a9 ; (sprintf.s10 + 0)
.s8:
1787 : a4 49 __ LDY T2 + 0 
1789 : 91 16 __ STA (P9),y ; (str + 0)
178b : e6 55 __ INC T4 + 0 
178d : d0 02 __ BNE $1791 ; (sprintf.s114 + 0)
.s113:
178f : e6 56 __ INC T4 + 1 
.s114:
1791 : c8 __ __ INY
1792 : 84 49 __ STY T2 + 0 
1794 : 98 __ __ TYA
1795 : c0 28 __ CPY #$28
1797 : 90 d5 __ BCC $176e ; (sprintf.l5 + 0)
.s9:
1799 : 18 __ __ CLC
179a : 65 16 __ ADC P9 ; (str + 0)
179c : 85 16 __ STA P9 ; (str + 0)
179e : 90 02 __ BCC $17a2 ; (sprintf.s116 + 0)
.s115:
17a0 : e6 17 __ INC P10 ; (str + 1)
.s116:
17a2 : a9 00 __ LDA #$00
.s87:
17a4 : 85 49 __ STA T2 + 0 
17a6 : 4c 6e 17 JMP $176e ; (sprintf.l5 + 0)
.s10:
17a9 : 8c e5 9f STY $9fe5 ; (si.prefix + 0)
17ac : a5 49 __ LDA T2 + 0 
17ae : f0 0c __ BEQ $17bc ; (sprintf.s11 + 0)
.s82:
17b0 : 84 49 __ STY T2 + 0 
17b2 : 18 __ __ CLC
17b3 : 65 16 __ ADC P9 ; (str + 0)
17b5 : 85 16 __ STA P9 ; (str + 0)
17b7 : 90 02 __ BCC $17bb ; (sprintf.s95 + 0)
.s94:
17b9 : e6 17 __ INC P10 ; (str + 1)
.s95:
17bb : 98 __ __ TYA
.s11:
17bc : 8d e3 9f STA $9fe3 ; (si.sign + 0)
17bf : 8d e4 9f STA $9fe4 ; (si.left + 0)
17c2 : a0 01 __ LDY #$01
17c4 : b1 55 __ LDA (T4 + 0),y 
17c6 : a2 20 __ LDX #$20
17c8 : 8e de 9f STX $9fde ; (si.fill + 0)
17cb : a2 00 __ LDX #$00
17cd : 8e df 9f STX $9fdf ; (si.width + 0)
17d0 : ca __ __ DEX
17d1 : 8e e0 9f STX $9fe0 ; (si.precision + 0)
17d4 : a2 0a __ LDX #$0a
17d6 : 8e e2 9f STX $9fe2 ; (si.base + 0)
17d9 : aa __ __ TAX
17da : a9 02 __ LDA #$02
17dc : d0 07 __ BNE $17e5 ; (sprintf.l12 + 0)
.s78:
17de : a0 00 __ LDY #$00
17e0 : b1 55 __ LDA (T4 + 0),y 
17e2 : aa __ __ TAX
17e3 : a9 01 __ LDA #$01
.l12:
17e5 : 18 __ __ CLC
17e6 : 65 55 __ ADC T4 + 0 
17e8 : 85 55 __ STA T4 + 0 
17ea : 90 02 __ BCC $17ee ; (sprintf.s97 + 0)
.s96:
17ec : e6 56 __ INC T4 + 1 
.s97:
17ee : 8a __ __ TXA
17ef : e0 2b __ CPX #$2b
17f1 : d0 07 __ BNE $17fa ; (sprintf.s13 + 0)
.s81:
17f3 : a9 01 __ LDA #$01
17f5 : 8d e3 9f STA $9fe3 ; (si.sign + 0)
17f8 : d0 e4 __ BNE $17de ; (sprintf.s78 + 0)
.s13:
17fa : c9 30 __ CMP #$30
17fc : d0 06 __ BNE $1804 ; (sprintf.s14 + 0)
.s80:
17fe : 8d de 9f STA $9fde ; (si.fill + 0)
1801 : 4c de 17 JMP $17de ; (sprintf.s78 + 0)
.s14:
1804 : c9 23 __ CMP #$23
1806 : d0 07 __ BNE $180f ; (sprintf.s15 + 0)
.s79:
1808 : a9 01 __ LDA #$01
180a : 8d e5 9f STA $9fe5 ; (si.prefix + 0)
180d : d0 cf __ BNE $17de ; (sprintf.s78 + 0)
.s15:
180f : c9 2d __ CMP #$2d
1811 : d0 07 __ BNE $181a ; (sprintf.s16 + 0)
.s77:
1813 : a9 01 __ LDA #$01
1815 : 8d e4 9f STA $9fe4 ; (si.left + 0)
1818 : d0 c4 __ BNE $17de ; (sprintf.s78 + 0)
.s16:
181a : 85 4b __ STA T6 + 0 
181c : c9 30 __ CMP #$30
181e : 90 31 __ BCC $1851 ; (sprintf.s17 + 0)
.s72:
1820 : c9 3a __ CMP #$3a
1822 : b0 5e __ BCS $1882 ; (sprintf.s18 + 0)
.s73:
1824 : a9 00 __ LDA #$00
1826 : 85 47 __ STA T1 + 0 
.l74:
1828 : a5 47 __ LDA T1 + 0 
182a : 0a __ __ ASL
182b : 0a __ __ ASL
182c : 18 __ __ CLC
182d : 65 47 __ ADC T1 + 0 
182f : 0a __ __ ASL
1830 : 18 __ __ CLC
1831 : 65 4b __ ADC T6 + 0 
1833 : 38 __ __ SEC
1834 : e9 30 __ SBC #$30
1836 : 85 47 __ STA T1 + 0 
1838 : a0 00 __ LDY #$00
183a : b1 55 __ LDA (T4 + 0),y 
183c : 85 4b __ STA T6 + 0 
183e : e6 55 __ INC T4 + 0 
1840 : d0 02 __ BNE $1844 ; (sprintf.s112 + 0)
.s111:
1842 : e6 56 __ INC T4 + 1 
.s112:
1844 : c9 30 __ CMP #$30
1846 : 90 04 __ BCC $184c ; (sprintf.s75 + 0)
.s76:
1848 : c9 3a __ CMP #$3a
184a : 90 dc __ BCC $1828 ; (sprintf.l74 + 0)
.s75:
184c : a6 47 __ LDX T1 + 0 
184e : 8e df 9f STX $9fdf ; (si.width + 0)
.s17:
1851 : c9 2e __ CMP #$2e
1853 : d0 2d __ BNE $1882 ; (sprintf.s18 + 0)
.s67:
1855 : a9 00 __ LDA #$00
1857 : f0 0e __ BEQ $1867 ; (sprintf.l68 + 0)
.s71:
1859 : a5 43 __ LDA T0 + 0 
185b : 0a __ __ ASL
185c : 0a __ __ ASL
185d : 18 __ __ CLC
185e : 65 43 __ ADC T0 + 0 
1860 : 0a __ __ ASL
1861 : 18 __ __ CLC
1862 : 65 4b __ ADC T6 + 0 
1864 : 38 __ __ SEC
1865 : e9 30 __ SBC #$30
.l68:
1867 : 85 43 __ STA T0 + 0 
1869 : a0 00 __ LDY #$00
186b : b1 55 __ LDA (T4 + 0),y 
186d : 85 4b __ STA T6 + 0 
186f : e6 55 __ INC T4 + 0 
1871 : d0 02 __ BNE $1875 ; (sprintf.s99 + 0)
.s98:
1873 : e6 56 __ INC T4 + 1 
.s99:
1875 : c9 30 __ CMP #$30
1877 : 90 04 __ BCC $187d ; (sprintf.s69 + 0)
.s70:
1879 : c9 3a __ CMP #$3a
187b : 90 dc __ BCC $1859 ; (sprintf.s71 + 0)
.s69:
187d : a6 43 __ LDX T0 + 0 
187f : 8e e0 9f STX $9fe0 ; (si.precision + 0)
.s18:
1882 : c9 64 __ CMP #$64
1884 : f0 0c __ BEQ $1892 ; (sprintf.s66 + 0)
.s19:
1886 : c9 44 __ CMP #$44
1888 : f0 08 __ BEQ $1892 ; (sprintf.s66 + 0)
.s20:
188a : c9 69 __ CMP #$69
188c : f0 04 __ BEQ $1892 ; (sprintf.s66 + 0)
.s21:
188e : c9 49 __ CMP #$49
1890 : d0 11 __ BNE $18a3 ; (sprintf.s22 + 0)
.s66:
1892 : a0 00 __ LDY #$00
1894 : b1 53 __ LDA (T3 + 0),y 
1896 : 85 11 __ STA P4 
1898 : c8 __ __ INY
1899 : b1 53 __ LDA (T3 + 0),y 
189b : 85 12 __ STA P5 
189d : 98 __ __ TYA
.s85:
189e : 85 13 __ STA P6 
18a0 : 4c 89 1a JMP $1a89 ; (sprintf.s64 + 0)
.s22:
18a3 : c9 75 __ CMP #$75
18a5 : f0 04 __ BEQ $18ab ; (sprintf.s65 + 0)
.s23:
18a7 : c9 55 __ CMP #$55
18a9 : d0 0f __ BNE $18ba ; (sprintf.s24 + 0)
.s65:
18ab : a0 00 __ LDY #$00
18ad : b1 53 __ LDA (T3 + 0),y 
18af : 85 11 __ STA P4 
18b1 : c8 __ __ INY
18b2 : b1 53 __ LDA (T3 + 0),y 
18b4 : 85 12 __ STA P5 
18b6 : a9 00 __ LDA #$00
18b8 : f0 e4 __ BEQ $189e ; (sprintf.s85 + 0)
.s24:
18ba : c9 78 __ CMP #$78
18bc : f0 04 __ BEQ $18c2 ; (sprintf.s63 + 0)
.s25:
18be : c9 58 __ CMP #$58
18c0 : d0 1e __ BNE $18e0 ; (sprintf.s26 + 0)
.s63:
18c2 : a0 00 __ LDY #$00
18c4 : 84 13 __ STY P6 
18c6 : a9 10 __ LDA #$10
18c8 : 8d e2 9f STA $9fe2 ; (si.base + 0)
18cb : b1 53 __ LDA (T3 + 0),y 
18cd : 85 11 __ STA P4 
18cf : c8 __ __ INY
18d0 : b1 53 __ LDA (T3 + 0),y 
18d2 : 85 12 __ STA P5 
18d4 : a5 4b __ LDA T6 + 0 
18d6 : 29 e0 __ AND #$e0
18d8 : 09 01 __ ORA #$01
18da : 8d e1 9f STA $9fe1 ; (si.cha + 0)
18dd : 4c 89 1a JMP $1a89 ; (sprintf.s64 + 0)
.s26:
18e0 : c9 6c __ CMP #$6c
18e2 : d0 03 __ BNE $18e7 ; (sprintf.s27 + 0)
18e4 : 4c 0e 1a JMP $1a0e ; (sprintf.s51 + 0)
.s27:
18e7 : c9 4c __ CMP #$4c
18e9 : f0 f9 __ BEQ $18e4 ; (sprintf.s26 + 4)
.s28:
18eb : c9 66 __ CMP #$66
18ed : f0 14 __ BEQ $1903 ; (sprintf.s50 + 0)
.s29:
18ef : c9 67 __ CMP #$67
18f1 : f0 10 __ BEQ $1903 ; (sprintf.s50 + 0)
.s30:
18f3 : c9 65 __ CMP #$65
18f5 : f0 0c __ BEQ $1903 ; (sprintf.s50 + 0)
.s31:
18f7 : c9 46 __ CMP #$46
18f9 : f0 08 __ BEQ $1903 ; (sprintf.s50 + 0)
.s32:
18fb : c9 47 __ CMP #$47
18fd : f0 04 __ BEQ $1903 ; (sprintf.s50 + 0)
.s33:
18ff : c9 45 __ CMP #$45
1901 : d0 44 __ BNE $1947 ; (sprintf.s34 + 0)
.s50:
1903 : a5 16 __ LDA P9 ; (str + 0)
1905 : 85 0f __ STA P2 
1907 : a5 17 __ LDA P10 ; (str + 1)
1909 : 85 10 __ STA P3 
190b : a0 00 __ LDY #$00
190d : b1 53 __ LDA (T3 + 0),y 
190f : 85 11 __ STA P4 
1911 : c8 __ __ INY
1912 : b1 53 __ LDA (T3 + 0),y 
1914 : 85 12 __ STA P5 
1916 : c8 __ __ INY
1917 : b1 53 __ LDA (T3 + 0),y 
1919 : 85 13 __ STA P6 
191b : c8 __ __ INY
191c : b1 53 __ LDA (T3 + 0),y 
191e : 85 14 __ STA P7 
1920 : a5 4b __ LDA T6 + 0 
1922 : 29 e0 __ AND #$e0
1924 : 09 01 __ ORA #$01
1926 : 8d e1 9f STA $9fe1 ; (si.cha + 0)
1929 : a9 de __ LDA #$de
192b : 85 0d __ STA P0 
192d : a9 9f __ LDA #$9f
192f : 85 0e __ STA P1 
1931 : a5 4b __ LDA T6 + 0 
1933 : ed e1 9f SBC $9fe1 ; (si.cha + 0)
1936 : 18 __ __ CLC
1937 : 69 61 __ ADC #$61
1939 : 85 15 __ STA P8 
193b : 20 08 1d JSR $1d08 ; (nformf.s1 + 0)
193e : a5 1b __ LDA ACCU + 0 ; (fmt + 2)
1940 : 85 49 __ STA T2 + 0 
1942 : a9 04 __ LDA #$04
1944 : 4c 02 1a JMP $1a02 ; (sprintf.s84 + 0)
.s34:
1947 : c9 73 __ CMP #$73
1949 : f0 2d __ BEQ $1978 ; (sprintf.s42 + 0)
.s35:
194b : c9 53 __ CMP #$53
194d : f0 29 __ BEQ $1978 ; (sprintf.s42 + 0)
.s36:
194f : c9 63 __ CMP #$63
1951 : f0 13 __ BEQ $1966 ; (sprintf.s41 + 0)
.s37:
1953 : c9 43 __ CMP #$43
1955 : f0 0f __ BEQ $1966 ; (sprintf.s41 + 0)
.s38:
1957 : aa __ __ TAX
1958 : d0 03 __ BNE $195d ; (sprintf.s39 + 0)
195a : 4c 6e 17 JMP $176e ; (sprintf.l5 + 0)
.s39:
195d : a0 00 __ LDY #$00
195f : 91 16 __ STA (P9),y ; (str + 0)
.s40:
1961 : a9 01 __ LDA #$01
1963 : 4c a4 17 JMP $17a4 ; (sprintf.s87 + 0)
.s41:
1966 : a0 00 __ LDY #$00
1968 : b1 53 __ LDA (T3 + 0),y 
196a : 91 16 __ STA (P9),y ; (str + 0)
196c : a5 53 __ LDA T3 + 0 
196e : 69 01 __ ADC #$01
1970 : 85 53 __ STA T3 + 0 
1972 : 90 ed __ BCC $1961 ; (sprintf.s40 + 0)
.s110:
1974 : e6 54 __ INC T3 + 1 
1976 : b0 e9 __ BCS $1961 ; (sprintf.s40 + 0)
.s42:
1978 : a0 00 __ LDY #$00
197a : 84 4b __ STY T6 + 0 
197c : b1 53 __ LDA (T3 + 0),y 
197e : 85 43 __ STA T0 + 0 
1980 : c8 __ __ INY
1981 : b1 53 __ LDA (T3 + 0),y 
1983 : 85 44 __ STA T0 + 1 
1985 : a5 53 __ LDA T3 + 0 
1987 : 69 01 __ ADC #$01
1989 : 85 53 __ STA T3 + 0 
198b : 90 02 __ BCC $198f ; (sprintf.s106 + 0)
.s105:
198d : e6 54 __ INC T3 + 1 
.s106:
198f : ad df 9f LDA $9fdf ; (si.width + 0)
1992 : f0 0d __ BEQ $19a1 ; (sprintf.s43 + 0)
.s91:
1994 : a0 00 __ LDY #$00
1996 : b1 43 __ LDA (T0 + 0),y 
1998 : f0 05 __ BEQ $199f ; (sprintf.s92 + 0)
.l49:
199a : c8 __ __ INY
199b : b1 43 __ LDA (T0 + 0),y 
199d : d0 fb __ BNE $199a ; (sprintf.l49 + 0)
.s92:
199f : 84 4b __ STY T6 + 0 
.s43:
19a1 : ad e4 9f LDA $9fe4 ; (si.left + 0)
19a4 : 85 4d __ STA T8 + 0 
19a6 : d0 19 __ BNE $19c1 ; (sprintf.s44 + 0)
.s89:
19a8 : a6 4b __ LDX T6 + 0 
19aa : ec df 9f CPX $9fdf ; (si.width + 0)
19ad : a0 00 __ LDY #$00
19af : b0 0c __ BCS $19bd ; (sprintf.s90 + 0)
.l48:
19b1 : ad de 9f LDA $9fde ; (si.fill + 0)
19b4 : 91 16 __ STA (P9),y ; (str + 0)
19b6 : c8 __ __ INY
19b7 : e8 __ __ INX
19b8 : ec df 9f CPX $9fdf ; (si.width + 0)
19bb : 90 f4 __ BCC $19b1 ; (sprintf.l48 + 0)
.s90:
19bd : 86 4b __ STX T6 + 0 
19bf : 84 49 __ STY T2 + 0 
.s44:
19c1 : a0 00 __ LDY #$00
19c3 : b1 43 __ LDA (T0 + 0),y 
19c5 : f0 1a __ BEQ $19e1 ; (sprintf.s45 + 0)
.s47:
19c7 : e6 43 __ INC T0 + 0 
19c9 : d0 02 __ BNE $19cd ; (sprintf.l83 + 0)
.s107:
19cb : e6 44 __ INC T0 + 1 
.l83:
19cd : a4 49 __ LDY T2 + 0 
19cf : 91 16 __ STA (P9),y ; (str + 0)
19d1 : e6 49 __ INC T2 + 0 
19d3 : a0 00 __ LDY #$00
19d5 : b1 43 __ LDA (T0 + 0),y 
19d7 : a8 __ __ TAY
19d8 : e6 43 __ INC T0 + 0 
19da : d0 02 __ BNE $19de ; (sprintf.s109 + 0)
.s108:
19dc : e6 44 __ INC T0 + 1 
.s109:
19de : 98 __ __ TYA
19df : d0 ec __ BNE $19cd ; (sprintf.l83 + 0)
.s45:
19e1 : a5 4d __ LDA T8 + 0 
19e3 : d0 03 __ BNE $19e8 ; (sprintf.s88 + 0)
19e5 : 4c 6e 17 JMP $176e ; (sprintf.l5 + 0)
.s88:
19e8 : a6 4b __ LDX T6 + 0 
19ea : ec df 9f CPX $9fdf ; (si.width + 0)
19ed : a4 49 __ LDY T2 + 0 
19ef : b0 0c __ BCS $19fd ; (sprintf.s93 + 0)
.l46:
19f1 : ad de 9f LDA $9fde ; (si.fill + 0)
19f4 : 91 16 __ STA (P9),y ; (str + 0)
19f6 : c8 __ __ INY
19f7 : e8 __ __ INX
19f8 : ec df 9f CPX $9fdf ; (si.width + 0)
19fb : 90 f4 __ BCC $19f1 ; (sprintf.l46 + 0)
.s93:
19fd : 84 49 __ STY T2 + 0 
19ff : 4c 6e 17 JMP $176e ; (sprintf.l5 + 0)
.s84:
1a02 : 18 __ __ CLC
1a03 : 65 53 __ ADC T3 + 0 
1a05 : 85 53 __ STA T3 + 0 
1a07 : 90 f6 __ BCC $19ff ; (sprintf.s93 + 2)
.s100:
1a09 : e6 54 __ INC T3 + 1 
1a0b : 4c 6e 17 JMP $176e ; (sprintf.l5 + 0)
.s51:
1a0e : a0 00 __ LDY #$00
1a10 : b1 53 __ LDA (T3 + 0),y 
1a12 : 85 11 __ STA P4 
1a14 : c8 __ __ INY
1a15 : b1 53 __ LDA (T3 + 0),y 
1a17 : 85 12 __ STA P5 
1a19 : c8 __ __ INY
1a1a : b1 53 __ LDA (T3 + 0),y 
1a1c : 85 13 __ STA P6 
1a1e : c8 __ __ INY
1a1f : b1 53 __ LDA (T3 + 0),y 
1a21 : 85 14 __ STA P7 
1a23 : a5 53 __ LDA T3 + 0 
1a25 : 69 03 __ ADC #$03
1a27 : 85 53 __ STA T3 + 0 
1a29 : 90 02 __ BCC $1a2d ; (sprintf.s102 + 0)
.s101:
1a2b : e6 54 __ INC T3 + 1 
.s102:
1a2d : a0 00 __ LDY #$00
1a2f : b1 55 __ LDA (T4 + 0),y 
1a31 : aa __ __ TAX
1a32 : e6 55 __ INC T4 + 0 
1a34 : d0 02 __ BNE $1a38 ; (sprintf.s104 + 0)
.s103:
1a36 : e6 56 __ INC T4 + 1 
.s104:
1a38 : e0 64 __ CPX #$64
1a3a : f0 0c __ BEQ $1a48 ; (sprintf.s62 + 0)
.s52:
1a3c : e0 44 __ CPX #$44
1a3e : f0 08 __ BEQ $1a48 ; (sprintf.s62 + 0)
.s53:
1a40 : e0 69 __ CPX #$69
1a42 : f0 04 __ BEQ $1a48 ; (sprintf.s62 + 0)
.s54:
1a44 : e0 49 __ CPX #$49
1a46 : d0 1c __ BNE $1a64 ; (sprintf.s55 + 0)
.s62:
1a48 : a9 01 __ LDA #$01
.s86:
1a4a : 85 15 __ STA P8 
.s60:
1a4c : a5 16 __ LDA P9 ; (str + 0)
1a4e : 85 0f __ STA P2 
1a50 : a5 17 __ LDA P10 ; (str + 1)
1a52 : 85 10 __ STA P3 
1a54 : a9 de __ LDA #$de
1a56 : 85 0d __ STA P0 
1a58 : a9 9f __ LDA #$9f
1a5a : 85 0e __ STA P1 
1a5c : 20 be 1b JSR $1bbe ; (nforml.s4 + 0)
1a5f : a5 1b __ LDA ACCU + 0 ; (fmt + 2)
1a61 : 4c a4 17 JMP $17a4 ; (sprintf.s87 + 0)
.s55:
1a64 : e0 75 __ CPX #$75
1a66 : f0 04 __ BEQ $1a6c ; (sprintf.s61 + 0)
.s56:
1a68 : e0 55 __ CPX #$55
1a6a : d0 03 __ BNE $1a6f ; (sprintf.s57 + 0)
.s61:
1a6c : 98 __ __ TYA
1a6d : f0 db __ BEQ $1a4a ; (sprintf.s86 + 0)
.s57:
1a6f : e0 78 __ CPX #$78
1a71 : f0 04 __ BEQ $1a77 ; (sprintf.s59 + 0)
.s58:
1a73 : e0 58 __ CPX #$58
1a75 : d0 94 __ BNE $1a0b ; (sprintf.s100 + 2)
.s59:
1a77 : 84 15 __ STY P8 
1a79 : a9 10 __ LDA #$10
1a7b : 8d e2 9f STA $9fe2 ; (si.base + 0)
1a7e : 8a __ __ TXA
1a7f : 29 e0 __ AND #$e0
1a81 : 09 01 __ ORA #$01
1a83 : 8d e1 9f STA $9fe1 ; (si.cha + 0)
1a86 : 4c 4c 1a JMP $1a4c ; (sprintf.s60 + 0)
.s64:
1a89 : a5 16 __ LDA P9 ; (str + 0)
1a8b : 85 0f __ STA P2 
1a8d : a5 17 __ LDA P10 ; (str + 1)
1a8f : 85 10 __ STA P3 
1a91 : a9 de __ LDA #$de
1a93 : 85 0d __ STA P0 
1a95 : a9 9f __ LDA #$9f
1a97 : 85 0e __ STA P1 
1a99 : 20 a3 1a JSR $1aa3 ; (nformi.s4 + 0)
1a9c : 85 49 __ STA T2 + 0 
1a9e : a9 02 __ LDA #$02
1aa0 : 4c 02 1a JMP $1a02 ; (sprintf.s84 + 0)
--------------------------------------------------------------------
nformi: ; nformi(const struct sinfo*,u8*,i16,bool)->u8
;  79, "/usr/local/include/oscar64/stdio.c"
.s4:
1aa3 : a9 00 __ LDA #$00
1aa5 : 85 43 __ STA T5 + 0 
1aa7 : a0 04 __ LDY #$04
1aa9 : b1 0d __ LDA (P0),y ; (si + 0)
1aab : 85 44 __ STA T6 + 0 
1aad : a5 13 __ LDA P6 ; (s + 0)
1aaf : f0 13 __ BEQ $1ac4 ; (nformi.s5 + 0)
.s33:
1ab1 : 24 12 __ BIT P5 ; (v + 1)
1ab3 : 10 0f __ BPL $1ac4 ; (nformi.s5 + 0)
.s34:
1ab5 : 38 __ __ SEC
1ab6 : a9 00 __ LDA #$00
1ab8 : e5 11 __ SBC P4 ; (v + 0)
1aba : 85 11 __ STA P4 ; (v + 0)
1abc : a9 00 __ LDA #$00
1abe : e5 12 __ SBC P5 ; (v + 1)
1ac0 : 85 12 __ STA P5 ; (v + 1)
1ac2 : e6 43 __ INC T5 + 0 
.s5:
1ac4 : a9 10 __ LDA #$10
1ac6 : 85 45 __ STA T7 + 0 
1ac8 : a5 11 __ LDA P4 ; (v + 0)
1aca : 05 12 __ ORA P5 ; (v + 1)
1acc : f0 33 __ BEQ $1b01 ; (nformi.s6 + 0)
.s28:
1ace : a5 11 __ LDA P4 ; (v + 0)
1ad0 : 85 1b __ STA ACCU + 0 
1ad2 : a5 12 __ LDA P5 ; (v + 1)
1ad4 : 85 1c __ STA ACCU + 1 
.l29:
1ad6 : a5 44 __ LDA T6 + 0 
1ad8 : 85 03 __ STA WORK + 0 
1ada : a9 00 __ LDA #$00
1adc : 85 04 __ STA WORK + 1 
1ade : 20 c5 31 JSR $31c5 ; (divmod + 0)
1ae1 : a5 05 __ LDA WORK + 2 
1ae3 : c9 0a __ CMP #$0a
1ae5 : b0 04 __ BCS $1aeb ; (nformi.s32 + 0)
.s30:
1ae7 : a9 30 __ LDA #$30
1ae9 : 90 06 __ BCC $1af1 ; (nformi.s31 + 0)
.s32:
1aeb : a0 03 __ LDY #$03
1aed : b1 0d __ LDA (P0),y ; (si + 0)
1aef : e9 0a __ SBC #$0a
.s31:
1af1 : 18 __ __ CLC
1af2 : 65 05 __ ADC WORK + 2 
1af4 : a6 45 __ LDX T7 + 0 
1af6 : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1af9 : c6 45 __ DEC T7 + 0 
1afb : a5 1b __ LDA ACCU + 0 
1afd : 05 1c __ ORA ACCU + 1 
1aff : d0 d5 __ BNE $1ad6 ; (nformi.l29 + 0)
.s6:
1b01 : a0 02 __ LDY #$02
1b03 : b1 0d __ LDA (P0),y ; (si + 0)
1b05 : c9 ff __ CMP #$ff
1b07 : d0 04 __ BNE $1b0d ; (nformi.s27 + 0)
.s7:
1b09 : a9 0f __ LDA #$0f
1b0b : d0 05 __ BNE $1b12 ; (nformi.s39 + 0)
.s27:
1b0d : 38 __ __ SEC
1b0e : a9 10 __ LDA #$10
1b10 : f1 0d __ SBC (P0),y ; (si + 0)
.s39:
1b12 : a8 __ __ TAY
1b13 : c4 45 __ CPY T7 + 0 
1b15 : b0 0d __ BCS $1b24 ; (nformi.s8 + 0)
.s26:
1b17 : a9 30 __ LDA #$30
.l40:
1b19 : a6 45 __ LDX T7 + 0 
1b1b : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1b1e : c6 45 __ DEC T7 + 0 
1b20 : c4 45 __ CPY T7 + 0 
1b22 : 90 f5 __ BCC $1b19 ; (nformi.l40 + 0)
.s8:
1b24 : a0 07 __ LDY #$07
1b26 : b1 0d __ LDA (P0),y ; (si + 0)
1b28 : f0 1c __ BEQ $1b46 ; (nformi.s9 + 0)
.s24:
1b2a : a5 44 __ LDA T6 + 0 
1b2c : c9 10 __ CMP #$10
1b2e : d0 16 __ BNE $1b46 ; (nformi.s9 + 0)
.s25:
1b30 : a0 03 __ LDY #$03
1b32 : b1 0d __ LDA (P0),y ; (si + 0)
1b34 : a8 __ __ TAY
1b35 : a9 30 __ LDA #$30
1b37 : a6 45 __ LDX T7 + 0 
1b39 : ca __ __ DEX
1b3a : ca __ __ DEX
1b3b : 86 45 __ STX T7 + 0 
1b3d : 9d e6 9f STA $9fe6,x ; (buffer[0] + 0)
1b40 : 98 __ __ TYA
1b41 : 69 16 __ ADC #$16
1b43 : 9d e7 9f STA $9fe7,x ; (buffer[0] + 1)
.s9:
1b46 : a9 00 __ LDA #$00
1b48 : 85 1b __ STA ACCU + 0 
1b4a : a5 43 __ LDA T5 + 0 
1b4c : f0 0c __ BEQ $1b5a ; (nformi.s10 + 0)
.s23:
1b4e : a9 2d __ LDA #$2d
.s22:
1b50 : a6 45 __ LDX T7 + 0 
1b52 : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1b55 : c6 45 __ DEC T7 + 0 
1b57 : 4c 64 1b JMP $1b64 ; (nformi.s11 + 0)
.s10:
1b5a : a0 05 __ LDY #$05
1b5c : b1 0d __ LDA (P0),y ; (si + 0)
1b5e : f0 04 __ BEQ $1b64 ; (nformi.s11 + 0)
.s21:
1b60 : a9 2b __ LDA #$2b
1b62 : d0 ec __ BNE $1b50 ; (nformi.s22 + 0)
.s11:
1b64 : a0 06 __ LDY #$06
1b66 : a6 45 __ LDX T7 + 0 
1b68 : b1 0d __ LDA (P0),y ; (si + 0)
1b6a : d0 2b __ BNE $1b97 ; (nformi.s17 + 0)
.l12:
1b6c : 8a __ __ TXA
1b6d : 18 __ __ CLC
1b6e : a0 01 __ LDY #$01
1b70 : 71 0d __ ADC (P0),y ; (si + 0)
1b72 : b0 04 __ BCS $1b78 ; (nformi.s15 + 0)
.s16:
1b74 : c9 11 __ CMP #$11
1b76 : 90 0a __ BCC $1b82 ; (nformi.s13 + 0)
.s15:
1b78 : a0 00 __ LDY #$00
1b7a : b1 0d __ LDA (P0),y ; (si + 0)
1b7c : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1b7f : ca __ __ DEX
1b80 : b0 ea __ BCS $1b6c ; (nformi.l12 + 0)
.s13:
1b82 : e0 10 __ CPX #$10
1b84 : b0 0e __ BCS $1b94 ; (nformi.s41 + 0)
.s14:
1b86 : 88 __ __ DEY
.l37:
1b87 : bd e6 9f LDA $9fe6,x ; (buffer[0] + 0)
1b8a : 91 0f __ STA (P2),y ; (str + 0)
1b8c : c8 __ __ INY
1b8d : e8 __ __ INX
1b8e : e0 10 __ CPX #$10
1b90 : 90 f5 __ BCC $1b87 ; (nformi.l37 + 0)
.s38:
1b92 : 84 1b __ STY ACCU + 0 
.s41:
1b94 : a5 1b __ LDA ACCU + 0 
.s3:
1b96 : 60 __ __ RTS
.s17:
1b97 : e0 10 __ CPX #$10
1b99 : b0 1a __ BCS $1bb5 ; (nformi.l18 + 0)
.s20:
1b9b : a0 00 __ LDY #$00
.l35:
1b9d : bd e6 9f LDA $9fe6,x ; (buffer[0] + 0)
1ba0 : 91 0f __ STA (P2),y ; (str + 0)
1ba2 : c8 __ __ INY
1ba3 : e8 __ __ INX
1ba4 : e0 10 __ CPX #$10
1ba6 : 90 f5 __ BCC $1b9d ; (nformi.l35 + 0)
.s36:
1ba8 : 84 1b __ STY ACCU + 0 
1baa : b0 09 __ BCS $1bb5 ; (nformi.l18 + 0)
.s19:
1bac : 88 __ __ DEY
1bad : b1 0d __ LDA (P0),y ; (si + 0)
1baf : a4 1b __ LDY ACCU + 0 
1bb1 : 91 0f __ STA (P2),y ; (str + 0)
1bb3 : e6 1b __ INC ACCU + 0 
.l18:
1bb5 : a5 1b __ LDA ACCU + 0 
1bb7 : a0 01 __ LDY #$01
1bb9 : d1 0d __ CMP (P0),y ; (si + 0)
1bbb : 90 ef __ BCC $1bac ; (nformi.s19 + 0)
1bbd : 60 __ __ RTS
--------------------------------------------------------------------
nforml: ; nforml(const struct sinfo*,u8*,i32,bool)->u8
; 137, "/usr/local/include/oscar64/stdio.c"
.s4:
1bbe : a9 00 __ LDA #$00
1bc0 : 85 43 __ STA T4 + 0 
1bc2 : a5 15 __ LDA P8 ; (s + 0)
1bc4 : f0 1f __ BEQ $1be5 ; (nforml.s5 + 0)
.s35:
1bc6 : 24 14 __ BIT P7 ; (v + 3)
1bc8 : 10 1b __ BPL $1be5 ; (nforml.s5 + 0)
.s36:
1bca : 38 __ __ SEC
1bcb : a9 00 __ LDA #$00
1bcd : e5 11 __ SBC P4 ; (v + 0)
1bcf : 85 11 __ STA P4 ; (v + 0)
1bd1 : a9 00 __ LDA #$00
1bd3 : e5 12 __ SBC P5 ; (v + 1)
1bd5 : 85 12 __ STA P5 ; (v + 1)
1bd7 : a9 00 __ LDA #$00
1bd9 : e5 13 __ SBC P6 ; (v + 2)
1bdb : 85 13 __ STA P6 ; (v + 2)
1bdd : a9 00 __ LDA #$00
1bdf : e5 14 __ SBC P7 ; (v + 3)
1be1 : 85 14 __ STA P7 ; (v + 3)
1be3 : e6 43 __ INC T4 + 0 
.s5:
1be5 : a9 10 __ LDA #$10
1be7 : 85 44 __ STA T5 + 0 
1be9 : a5 14 __ LDA P7 ; (v + 3)
1beb : f0 03 __ BEQ $1bf0 ; (nforml.s31 + 0)
1bed : 4c b8 1c JMP $1cb8 ; (nforml.l28 + 0)
.s31:
1bf0 : a5 13 __ LDA P6 ; (v + 2)
1bf2 : d0 f9 __ BNE $1bed ; (nforml.s5 + 8)
.s32:
1bf4 : a5 12 __ LDA P5 ; (v + 1)
1bf6 : d0 f5 __ BNE $1bed ; (nforml.s5 + 8)
.s33:
1bf8 : c5 11 __ CMP P4 ; (v + 0)
1bfa : 90 f1 __ BCC $1bed ; (nforml.s5 + 8)
.s6:
1bfc : a0 02 __ LDY #$02
1bfe : b1 0d __ LDA (P0),y ; (si + 0)
1c00 : c9 ff __ CMP #$ff
1c02 : d0 04 __ BNE $1c08 ; (nforml.s27 + 0)
.s7:
1c04 : a9 0f __ LDA #$0f
1c06 : d0 05 __ BNE $1c0d ; (nforml.s41 + 0)
.s27:
1c08 : 38 __ __ SEC
1c09 : a9 10 __ LDA #$10
1c0b : f1 0d __ SBC (P0),y ; (si + 0)
.s41:
1c0d : a8 __ __ TAY
1c0e : c4 44 __ CPY T5 + 0 
1c10 : b0 0d __ BCS $1c1f ; (nforml.s8 + 0)
.s26:
1c12 : a9 30 __ LDA #$30
.l42:
1c14 : a6 44 __ LDX T5 + 0 
1c16 : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1c19 : c6 44 __ DEC T5 + 0 
1c1b : c4 44 __ CPY T5 + 0 
1c1d : 90 f5 __ BCC $1c14 ; (nforml.l42 + 0)
.s8:
1c1f : a0 07 __ LDY #$07
1c21 : b1 0d __ LDA (P0),y ; (si + 0)
1c23 : f0 1d __ BEQ $1c42 ; (nforml.s9 + 0)
.s24:
1c25 : a0 04 __ LDY #$04
1c27 : b1 0d __ LDA (P0),y ; (si + 0)
1c29 : c9 10 __ CMP #$10
1c2b : d0 15 __ BNE $1c42 ; (nforml.s9 + 0)
.s25:
1c2d : 88 __ __ DEY
1c2e : b1 0d __ LDA (P0),y ; (si + 0)
1c30 : a8 __ __ TAY
1c31 : a9 30 __ LDA #$30
1c33 : a6 44 __ LDX T5 + 0 
1c35 : ca __ __ DEX
1c36 : ca __ __ DEX
1c37 : 86 44 __ STX T5 + 0 
1c39 : 9d e6 9f STA $9fe6,x ; (buffer[0] + 0)
1c3c : 98 __ __ TYA
1c3d : 69 16 __ ADC #$16
1c3f : 9d e7 9f STA $9fe7,x ; (buffer[0] + 1)
.s9:
1c42 : a9 00 __ LDA #$00
1c44 : 85 1b __ STA ACCU + 0 
1c46 : a5 43 __ LDA T4 + 0 
1c48 : f0 0c __ BEQ $1c56 ; (nforml.s10 + 0)
.s23:
1c4a : a9 2d __ LDA #$2d
.s22:
1c4c : a6 44 __ LDX T5 + 0 
1c4e : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1c51 : c6 44 __ DEC T5 + 0 
1c53 : 4c 60 1c JMP $1c60 ; (nforml.s11 + 0)
.s10:
1c56 : a0 05 __ LDY #$05
1c58 : b1 0d __ LDA (P0),y ; (si + 0)
1c5a : f0 04 __ BEQ $1c60 ; (nforml.s11 + 0)
.s21:
1c5c : a9 2b __ LDA #$2b
1c5e : d0 ec __ BNE $1c4c ; (nforml.s22 + 0)
.s11:
1c60 : a6 44 __ LDX T5 + 0 
1c62 : a0 06 __ LDY #$06
1c64 : b1 0d __ LDA (P0),y ; (si + 0)
1c66 : d0 29 __ BNE $1c91 ; (nforml.s17 + 0)
.l12:
1c68 : 8a __ __ TXA
1c69 : 18 __ __ CLC
1c6a : a0 01 __ LDY #$01
1c6c : 71 0d __ ADC (P0),y ; (si + 0)
1c6e : b0 04 __ BCS $1c74 ; (nforml.s15 + 0)
.s16:
1c70 : c9 11 __ CMP #$11
1c72 : 90 0a __ BCC $1c7e ; (nforml.s13 + 0)
.s15:
1c74 : a0 00 __ LDY #$00
1c76 : b1 0d __ LDA (P0),y ; (si + 0)
1c78 : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1c7b : ca __ __ DEX
1c7c : b0 ea __ BCS $1c68 ; (nforml.l12 + 0)
.s13:
1c7e : e0 10 __ CPX #$10
1c80 : b0 0e __ BCS $1c90 ; (nforml.s3 + 0)
.s14:
1c82 : 88 __ __ DEY
.l39:
1c83 : bd e6 9f LDA $9fe6,x ; (buffer[0] + 0)
1c86 : 91 0f __ STA (P2),y ; (str + 0)
1c88 : c8 __ __ INY
1c89 : e8 __ __ INX
1c8a : e0 10 __ CPX #$10
1c8c : 90 f5 __ BCC $1c83 ; (nforml.l39 + 0)
.s40:
1c8e : 84 1b __ STY ACCU + 0 
.s3:
1c90 : 60 __ __ RTS
.s17:
1c91 : e0 10 __ CPX #$10
1c93 : b0 1a __ BCS $1caf ; (nforml.l18 + 0)
.s20:
1c95 : a0 00 __ LDY #$00
.l37:
1c97 : bd e6 9f LDA $9fe6,x ; (buffer[0] + 0)
1c9a : 91 0f __ STA (P2),y ; (str + 0)
1c9c : c8 __ __ INY
1c9d : e8 __ __ INX
1c9e : e0 10 __ CPX #$10
1ca0 : 90 f5 __ BCC $1c97 ; (nforml.l37 + 0)
.s38:
1ca2 : 84 1b __ STY ACCU + 0 
1ca4 : b0 09 __ BCS $1caf ; (nforml.l18 + 0)
.s19:
1ca6 : 88 __ __ DEY
1ca7 : b1 0d __ LDA (P0),y ; (si + 0)
1ca9 : a4 1b __ LDY ACCU + 0 
1cab : 91 0f __ STA (P2),y ; (str + 0)
1cad : e6 1b __ INC ACCU + 0 
.l18:
1caf : a5 1b __ LDA ACCU + 0 
1cb1 : a0 01 __ LDY #$01
1cb3 : d1 0d __ CMP (P0),y ; (si + 0)
1cb5 : 90 ef __ BCC $1ca6 ; (nforml.s19 + 0)
1cb7 : 60 __ __ RTS
.l28:
1cb8 : a0 04 __ LDY #$04
1cba : b1 0d __ LDA (P0),y ; (si + 0)
1cbc : 85 03 __ STA WORK + 0 
1cbe : a5 11 __ LDA P4 ; (v + 0)
1cc0 : 85 1b __ STA ACCU + 0 
1cc2 : a5 12 __ LDA P5 ; (v + 1)
1cc4 : 85 1c __ STA ACCU + 1 
1cc6 : a5 13 __ LDA P6 ; (v + 2)
1cc8 : 85 1d __ STA ACCU + 2 
1cca : a5 14 __ LDA P7 ; (v + 3)
1ccc : 85 1e __ STA ACCU + 3 
1cce : a9 00 __ LDA #$00
1cd0 : 85 04 __ STA WORK + 1 
1cd2 : 85 05 __ STA WORK + 2 
1cd4 : 85 06 __ STA WORK + 3 
1cd6 : 20 52 33 JSR $3352 ; (divmod32 + 0)
1cd9 : a5 07 __ LDA WORK + 4 
1cdb : c9 0a __ CMP #$0a
1cdd : b0 04 __ BCS $1ce3 ; (nforml.s34 + 0)
.s29:
1cdf : a9 30 __ LDA #$30
1ce1 : 90 06 __ BCC $1ce9 ; (nforml.s30 + 0)
.s34:
1ce3 : a0 03 __ LDY #$03
1ce5 : b1 0d __ LDA (P0),y ; (si + 0)
1ce7 : e9 0a __ SBC #$0a
.s30:
1ce9 : 18 __ __ CLC
1cea : 65 07 __ ADC WORK + 4 
1cec : a6 44 __ LDX T5 + 0 
1cee : 9d e5 9f STA $9fe5,x ; (si.prefix + 0)
1cf1 : c6 44 __ DEC T5 + 0 
1cf3 : a5 1b __ LDA ACCU + 0 
1cf5 : 85 11 __ STA P4 ; (v + 0)
1cf7 : a5 1c __ LDA ACCU + 1 
1cf9 : 85 12 __ STA P5 ; (v + 1)
1cfb : a5 1d __ LDA ACCU + 2 
1cfd : 85 13 __ STA P6 ; (v + 2)
1cff : a5 1e __ LDA ACCU + 3 
1d01 : 85 14 __ STA P7 ; (v + 3)
1d03 : d0 b3 __ BNE $1cb8 ; (nforml.l28 + 0)
1d05 : 4c f0 1b JMP $1bf0 ; (nforml.s31 + 0)
--------------------------------------------------------------------
nformf: ; nformf(const struct sinfo*,u8*,float,u8)->u8
; 199, "/usr/local/include/oscar64/stdio.c"
.s1:
1d08 : a5 53 __ LDA T10 + 0 
1d0a : 8d ed 9f STA $9fed ; (nformf@stack + 0)
1d0d : a5 54 __ LDA T11 + 0 
1d0f : 8d ee 9f STA $9fee ; (nformf@stack + 1)
.s4:
1d12 : a5 11 __ LDA P4 ; (f + 0)
1d14 : 85 43 __ STA T0 + 0 
1d16 : a5 12 __ LDA P5 ; (f + 1)
1d18 : 85 44 __ STA T0 + 1 
1d1a : a5 14 __ LDA P7 ; (f + 3)
1d1c : 29 7f __ AND #$7f
1d1e : 05 13 __ ORA P6 ; (f + 2)
1d20 : 05 12 __ ORA P5 ; (f + 1)
1d22 : a6 13 __ LDX P6 ; (f + 2)
1d24 : 86 45 __ STX T0 + 2 
1d26 : 05 11 __ ORA P4 ; (f + 0)
1d28 : f0 14 __ BEQ $1d3e ; (nformf.s5 + 0)
.s105:
1d2a : 24 14 __ BIT P7 ; (f + 3)
1d2c : 10 10 __ BPL $1d3e ; (nformf.s5 + 0)
.s104:
1d2e : a9 2d __ LDA #$2d
1d30 : a0 00 __ LDY #$00
1d32 : 91 0f __ STA (P2),y ; (str + 0)
1d34 : a5 14 __ LDA P7 ; (f + 3)
1d36 : 49 80 __ EOR #$80
1d38 : 85 14 __ STA P7 ; (f + 3)
.s103:
1d3a : a9 01 __ LDA #$01
1d3c : d0 0e __ BNE $1d4c ; (nformf.s6 + 0)
.s5:
1d3e : a0 05 __ LDY #$05
1d40 : b1 0d __ LDA (P0),y ; (si + 0)
1d42 : f0 08 __ BEQ $1d4c ; (nformf.s6 + 0)
.s102:
1d44 : a9 2b __ LDA #$2b
1d46 : a0 00 __ LDY #$00
1d48 : 91 0f __ STA (P2),y ; (str + 0)
1d4a : a9 01 __ LDA #$01
.s6:
1d4c : 85 52 __ STA T9 + 0 
1d4e : 8a __ __ TXA
1d4f : 0a __ __ ASL
1d50 : a5 14 __ LDA P7 ; (f + 3)
1d52 : 2a __ __ ROL
1d53 : c9 ff __ CMP #$ff
1d55 : d0 29 __ BNE $1d80 ; (nformf.s7 + 0)
.s101:
1d57 : a0 03 __ LDY #$03
1d59 : b1 0d __ LDA (P0),y ; (si + 0)
1d5b : 69 07 __ ADC #$07
1d5d : a4 52 __ LDY T9 + 0 
1d5f : 91 0f __ STA (P2),y ; (str + 0)
1d61 : 18 __ __ CLC
1d62 : a0 03 __ LDY #$03
1d64 : b1 0d __ LDA (P0),y ; (si + 0)
1d66 : 69 0d __ ADC #$0d
1d68 : a4 52 __ LDY T9 + 0 
1d6a : c8 __ __ INY
1d6b : 91 0f __ STA (P2),y ; (str + 0)
1d6d : 18 __ __ CLC
1d6e : a0 03 __ LDY #$03
1d70 : b1 0d __ LDA (P0),y ; (si + 0)
1d72 : 69 05 __ ADC #$05
1d74 : a4 52 __ LDY T9 + 0 
1d76 : c8 __ __ INY
1d77 : c8 __ __ INY
1d78 : 91 0f __ STA (P2),y ; (str + 0)
1d7a : c8 __ __ INY
1d7b : 84 52 __ STY T9 + 0 
1d7d : 4c ce 20 JMP $20ce ; (nformf.s27 + 0)
.s7:
1d80 : a0 02 __ LDY #$02
1d82 : b1 0d __ LDA (P0),y ; (si + 0)
1d84 : a6 14 __ LDX P7 ; (f + 3)
1d86 : 86 46 __ STX T0 + 3 
1d88 : c9 ff __ CMP #$ff
1d8a : d0 02 __ BNE $1d8e ; (nformf.s100 + 0)
.s8:
1d8c : a9 06 __ LDA #$06
.s100:
1d8e : 85 4b __ STA T4 + 0 
1d90 : 85 50 __ STA T7 + 0 
1d92 : a9 00 __ LDA #$00
1d94 : 85 4d __ STA T5 + 0 
1d96 : 85 4e __ STA T5 + 1 
1d98 : 8a __ __ TXA
1d99 : 29 7f __ AND #$7f
1d9b : 05 13 __ ORA P6 ; (f + 2)
1d9d : 05 12 __ ORA P5 ; (f + 1)
1d9f : 05 11 __ ORA P4 ; (f + 0)
1da1 : d0 03 __ BNE $1da6 ; (nformf.s67 + 0)
1da3 : 4c d2 1e JMP $1ed2 ; (nformf.s9 + 0)
.s67:
1da6 : 8a __ __ TXA
1da7 : 10 03 __ BPL $1dac ; (nformf.s95 + 0)
1da9 : 4c 2c 1e JMP $1e2c ; (nformf.l80 + 0)
.s95:
1dac : c9 44 __ CMP #$44
1dae : d0 0e __ BNE $1dbe ; (nformf.l99 + 0)
.s96:
1db0 : a5 13 __ LDA P6 ; (f + 2)
1db2 : c9 7a __ CMP #$7a
1db4 : d0 08 __ BNE $1dbe ; (nformf.l99 + 0)
.s97:
1db6 : a5 12 __ LDA P5 ; (f + 1)
1db8 : d0 04 __ BNE $1dbe ; (nformf.l99 + 0)
.s98:
1dba : a5 11 __ LDA P4 ; (f + 0)
1dbc : f0 02 __ BEQ $1dc0 ; (nformf.l90 + 0)
.l99:
1dbe : 90 54 __ BCC $1e14 ; (nformf.s68 + 0)
.l90:
1dc0 : 18 __ __ CLC
1dc1 : a5 4d __ LDA T5 + 0 
1dc3 : 69 03 __ ADC #$03
1dc5 : 85 4d __ STA T5 + 0 
1dc7 : 90 02 __ BCC $1dcb ; (nformf.s119 + 0)
.s118:
1dc9 : e6 4e __ INC T5 + 1 
.s119:
1dcb : a5 43 __ LDA T0 + 0 
1dcd : 85 1b __ STA ACCU + 0 
1dcf : a5 44 __ LDA T0 + 1 
1dd1 : 85 1c __ STA ACCU + 1 
1dd3 : a5 45 __ LDA T0 + 2 
1dd5 : 85 1d __ STA ACCU + 2 
1dd7 : a5 46 __ LDA T0 + 3 
1dd9 : 85 1e __ STA ACCU + 3 
1ddb : a9 00 __ LDA #$00
1ddd : 85 03 __ STA WORK + 0 
1ddf : 85 04 __ STA WORK + 1 
1de1 : a9 7a __ LDA #$7a
1de3 : 85 05 __ STA WORK + 2 
1de5 : a9 44 __ LDA #$44
1de7 : 85 06 __ STA WORK + 3 
1de9 : 20 fa 2e JSR $2efa ; (freg + 20)
1dec : 20 e0 30 JSR $30e0 ; (crt_fdiv + 0)
1def : a5 1b __ LDA ACCU + 0 
1df1 : 85 43 __ STA T0 + 0 
1df3 : a5 1c __ LDA ACCU + 1 
1df5 : 85 44 __ STA T0 + 1 
1df7 : a6 1d __ LDX ACCU + 2 
1df9 : 86 45 __ STX T0 + 2 
1dfb : a5 1e __ LDA ACCU + 3 
1dfd : 85 46 __ STA T0 + 3 
1dff : 30 13 __ BMI $1e14 ; (nformf.s68 + 0)
.s91:
1e01 : c9 44 __ CMP #$44
1e03 : d0 b9 __ BNE $1dbe ; (nformf.l99 + 0)
.s92:
1e05 : e0 7a __ CPX #$7a
1e07 : d0 b5 __ BNE $1dbe ; (nformf.l99 + 0)
.s93:
1e09 : a5 1c __ LDA ACCU + 1 
1e0b : 38 __ __ SEC
1e0c : d0 b0 __ BNE $1dbe ; (nformf.l99 + 0)
.s94:
1e0e : a5 1b __ LDA ACCU + 0 
1e10 : f0 ae __ BEQ $1dc0 ; (nformf.l90 + 0)
1e12 : d0 aa __ BNE $1dbe ; (nformf.l99 + 0)
.s68:
1e14 : a5 46 __ LDA T0 + 3 
1e16 : 30 14 __ BMI $1e2c ; (nformf.l80 + 0)
.s86:
1e18 : c9 3f __ CMP #$3f
1e1a : d0 0e __ BNE $1e2a ; (nformf.s85 + 0)
.s87:
1e1c : a5 45 __ LDA T0 + 2 
1e1e : c9 80 __ CMP #$80
1e20 : d0 08 __ BNE $1e2a ; (nformf.s85 + 0)
.s88:
1e22 : a5 44 __ LDA T0 + 1 
1e24 : d0 04 __ BNE $1e2a ; (nformf.s85 + 0)
.s89:
1e26 : a5 43 __ LDA T0 + 0 
1e28 : f0 49 __ BEQ $1e73 ; (nformf.s69 + 0)
.s85:
1e2a : b0 47 __ BCS $1e73 ; (nformf.s69 + 0)
.l80:
1e2c : 38 __ __ SEC
1e2d : a5 4d __ LDA T5 + 0 
1e2f : e9 03 __ SBC #$03
1e31 : 85 4d __ STA T5 + 0 
1e33 : b0 02 __ BCS $1e37 ; (nformf.s114 + 0)
.s113:
1e35 : c6 4e __ DEC T5 + 1 
.s114:
1e37 : a9 00 __ LDA #$00
1e39 : 85 1b __ STA ACCU + 0 
1e3b : 85 1c __ STA ACCU + 1 
1e3d : a9 7a __ LDA #$7a
1e3f : 85 1d __ STA ACCU + 2 
1e41 : a9 44 __ LDA #$44
1e43 : 85 1e __ STA ACCU + 3 
1e45 : a2 43 __ LDX #$43
1e47 : 20 ea 2e JSR $2eea ; (freg + 4)
1e4a : 20 18 30 JSR $3018 ; (crt_fmul + 0)
1e4d : a5 1b __ LDA ACCU + 0 
1e4f : 85 43 __ STA T0 + 0 
1e51 : a5 1c __ LDA ACCU + 1 
1e53 : 85 44 __ STA T0 + 1 
1e55 : a6 1d __ LDX ACCU + 2 
1e57 : 86 45 __ STX T0 + 2 
1e59 : a5 1e __ LDA ACCU + 3 
1e5b : 85 46 __ STA T0 + 3 
1e5d : 30 cd __ BMI $1e2c ; (nformf.l80 + 0)
.s81:
1e5f : c9 3f __ CMP #$3f
1e61 : 90 c9 __ BCC $1e2c ; (nformf.l80 + 0)
.s120:
1e63 : d0 0e __ BNE $1e73 ; (nformf.s69 + 0)
.s82:
1e65 : e0 80 __ CPX #$80
1e67 : 90 c3 __ BCC $1e2c ; (nformf.l80 + 0)
.s121:
1e69 : d0 08 __ BNE $1e73 ; (nformf.s69 + 0)
.s83:
1e6b : a5 1c __ LDA ACCU + 1 
1e6d : d0 bb __ BNE $1e2a ; (nformf.s85 + 0)
.s84:
1e6f : a5 1b __ LDA ACCU + 0 
1e71 : d0 b7 __ BNE $1e2a ; (nformf.s85 + 0)
.s69:
1e73 : a5 46 __ LDA T0 + 3 
1e75 : 30 5b __ BMI $1ed2 ; (nformf.s9 + 0)
.s75:
1e77 : c9 41 __ CMP #$41
1e79 : d0 0e __ BNE $1e89 ; (nformf.l79 + 0)
.s76:
1e7b : a5 45 __ LDA T0 + 2 
1e7d : c9 20 __ CMP #$20
1e7f : d0 08 __ BNE $1e89 ; (nformf.l79 + 0)
.s77:
1e81 : a5 44 __ LDA T0 + 1 
1e83 : d0 04 __ BNE $1e89 ; (nformf.l79 + 0)
.s78:
1e85 : a5 43 __ LDA T0 + 0 
1e87 : f0 02 __ BEQ $1e8b ; (nformf.l70 + 0)
.l79:
1e89 : 90 47 __ BCC $1ed2 ; (nformf.s9 + 0)
.l70:
1e8b : e6 4d __ INC T5 + 0 
1e8d : d0 02 __ BNE $1e91 ; (nformf.s117 + 0)
.s116:
1e8f : e6 4e __ INC T5 + 1 
.s117:
1e91 : a5 43 __ LDA T0 + 0 
1e93 : 85 1b __ STA ACCU + 0 
1e95 : a5 44 __ LDA T0 + 1 
1e97 : 85 1c __ STA ACCU + 1 
1e99 : a5 45 __ LDA T0 + 2 
1e9b : 85 1d __ STA ACCU + 2 
1e9d : a5 46 __ LDA T0 + 3 
1e9f : 85 1e __ STA ACCU + 3 
1ea1 : a9 00 __ LDA #$00
1ea3 : 85 03 __ STA WORK + 0 
1ea5 : 85 04 __ STA WORK + 1 
1ea7 : 20 be 35 JSR $35be ; (freg@proxy + 0)
1eaa : 20 e0 30 JSR $30e0 ; (crt_fdiv + 0)
1ead : a5 1b __ LDA ACCU + 0 
1eaf : 85 43 __ STA T0 + 0 
1eb1 : a5 1c __ LDA ACCU + 1 
1eb3 : 85 44 __ STA T0 + 1 
1eb5 : a6 1d __ LDX ACCU + 2 
1eb7 : 86 45 __ STX T0 + 2 
1eb9 : a5 1e __ LDA ACCU + 3 
1ebb : 85 46 __ STA T0 + 3 
1ebd : 30 13 __ BMI $1ed2 ; (nformf.s9 + 0)
.s71:
1ebf : c9 41 __ CMP #$41
1ec1 : d0 c6 __ BNE $1e89 ; (nformf.l79 + 0)
.s72:
1ec3 : e0 20 __ CPX #$20
1ec5 : d0 c2 __ BNE $1e89 ; (nformf.l79 + 0)
.s73:
1ec7 : a5 1c __ LDA ACCU + 1 
1ec9 : 38 __ __ SEC
1eca : d0 bd __ BNE $1e89 ; (nformf.l79 + 0)
.s74:
1ecc : a5 1b __ LDA ACCU + 0 
1ece : f0 bb __ BEQ $1e8b ; (nformf.l70 + 0)
1ed0 : d0 b7 __ BNE $1e89 ; (nformf.l79 + 0)
.s9:
1ed2 : a5 15 __ LDA P8 ; (type + 0)
1ed4 : c9 65 __ CMP #$65
1ed6 : d0 04 __ BNE $1edc ; (nformf.s11 + 0)
.s10:
1ed8 : a9 01 __ LDA #$01
1eda : d0 02 __ BNE $1ede ; (nformf.s12 + 0)
.s11:
1edc : a9 00 __ LDA #$00
.s12:
1ede : 85 53 __ STA T10 + 0 
1ee0 : a6 4b __ LDX T4 + 0 
1ee2 : e8 __ __ INX
1ee3 : 86 4f __ STX T6 + 0 
1ee5 : a5 15 __ LDA P8 ; (type + 0)
1ee7 : c9 67 __ CMP #$67
1ee9 : d0 13 __ BNE $1efe ; (nformf.s13 + 0)
.s63:
1eeb : a5 4e __ LDA T5 + 1 
1eed : 30 08 __ BMI $1ef7 ; (nformf.s64 + 0)
.s66:
1eef : d0 06 __ BNE $1ef7 ; (nformf.s64 + 0)
.s65:
1ef1 : a5 4d __ LDA T5 + 0 
1ef3 : c9 04 __ CMP #$04
1ef5 : 90 07 __ BCC $1efe ; (nformf.s13 + 0)
.s64:
1ef7 : a9 01 __ LDA #$01
1ef9 : 85 53 __ STA T10 + 0 
1efb : 4c 5f 21 JMP $215f ; (nformf.s53 + 0)
.s13:
1efe : a5 53 __ LDA T10 + 0 
1f00 : d0 f9 __ BNE $1efb ; (nformf.s64 + 4)
.s14:
1f02 : 24 4e __ BIT T5 + 1 
1f04 : 10 3b __ BPL $1f41 ; (nformf.s15 + 0)
.s52:
1f06 : a5 43 __ LDA T0 + 0 
1f08 : 85 1b __ STA ACCU + 0 
1f0a : a5 44 __ LDA T0 + 1 
1f0c : 85 1c __ STA ACCU + 1 
1f0e : a5 45 __ LDA T0 + 2 
1f10 : 85 1d __ STA ACCU + 2 
1f12 : a5 46 __ LDA T0 + 3 
1f14 : 85 1e __ STA ACCU + 3 
.l106:
1f16 : a9 00 __ LDA #$00
1f18 : 85 03 __ STA WORK + 0 
1f1a : 85 04 __ STA WORK + 1 
1f1c : 20 be 35 JSR $35be ; (freg@proxy + 0)
1f1f : 20 e0 30 JSR $30e0 ; (crt_fdiv + 0)
1f22 : 18 __ __ CLC
1f23 : a5 4d __ LDA T5 + 0 
1f25 : 69 01 __ ADC #$01
1f27 : 85 4d __ STA T5 + 0 
1f29 : a5 4e __ LDA T5 + 1 
1f2b : 69 00 __ ADC #$00
1f2d : 85 4e __ STA T5 + 1 
1f2f : 30 e5 __ BMI $1f16 ; (nformf.l106 + 0)
.s107:
1f31 : a5 1e __ LDA ACCU + 3 
1f33 : 85 46 __ STA T0 + 3 
1f35 : a5 1d __ LDA ACCU + 2 
1f37 : 85 45 __ STA T0 + 2 
1f39 : a5 1c __ LDA ACCU + 1 
1f3b : 85 44 __ STA T0 + 1 
1f3d : a5 1b __ LDA ACCU + 0 
1f3f : 85 43 __ STA T0 + 0 
.s15:
1f41 : 18 __ __ CLC
1f42 : a5 4b __ LDA T4 + 0 
1f44 : 65 4d __ ADC T5 + 0 
1f46 : 18 __ __ CLC
1f47 : 69 01 __ ADC #$01
1f49 : 85 4f __ STA T6 + 0 
1f4b : c9 07 __ CMP #$07
1f4d : 90 14 __ BCC $1f63 ; (nformf.s51 + 0)
.s16:
1f4f : ad 18 37 LDA $3718 ; (fround5[0] + 24)
1f52 : 85 47 __ STA T1 + 0 
1f54 : ad 19 37 LDA $3719 ; (fround5[0] + 25)
1f57 : 85 48 __ STA T1 + 1 
1f59 : ad 1a 37 LDA $371a ; (fround5[0] + 26)
1f5c : 85 49 __ STA T1 + 2 
1f5e : ad 1b 37 LDA $371b ; (fround5[0] + 27)
1f61 : b0 15 __ BCS $1f78 ; (nformf.s17 + 0)
.s51:
1f63 : 0a __ __ ASL
1f64 : 0a __ __ ASL
1f65 : aa __ __ TAX
1f66 : bd fc 36 LDA $36fc,x ; (temp_char[0] + 1)
1f69 : 85 47 __ STA T1 + 0 
1f6b : bd fd 36 LDA $36fd,x 
1f6e : 85 48 __ STA T1 + 1 
1f70 : bd fe 36 LDA $36fe,x 
1f73 : 85 49 __ STA T1 + 2 
1f75 : bd ff 36 LDA $36ff,x 
.s17:
1f78 : 85 4a __ STA T1 + 3 
1f7a : a2 47 __ LDX #$47
1f7c : 20 c9 35 JSR $35c9 ; (freg@proxy + 0)
1f7f : 20 31 2f JSR $2f31 ; (faddsub + 6)
1f82 : a5 1c __ LDA ACCU + 1 
1f84 : 85 12 __ STA P5 ; (f + 1)
1f86 : a5 1d __ LDA ACCU + 2 
1f88 : 85 13 __ STA P6 ; (f + 2)
1f8a : a6 1b __ LDX ACCU + 0 
1f8c : a5 1e __ LDA ACCU + 3 
1f8e : 85 14 __ STA P7 ; (f + 3)
1f90 : 30 32 __ BMI $1fc4 ; (nformf.s18 + 0)
.s46:
1f92 : c9 41 __ CMP #$41
1f94 : d0 0d __ BNE $1fa3 ; (nformf.s50 + 0)
.s47:
1f96 : a5 13 __ LDA P6 ; (f + 2)
1f98 : c9 20 __ CMP #$20
1f9a : d0 07 __ BNE $1fa3 ; (nformf.s50 + 0)
.s48:
1f9c : a5 12 __ LDA P5 ; (f + 1)
1f9e : d0 03 __ BNE $1fa3 ; (nformf.s50 + 0)
.s49:
1fa0 : 8a __ __ TXA
1fa1 : f0 02 __ BEQ $1fa5 ; (nformf.s45 + 0)
.s50:
1fa3 : 90 1f __ BCC $1fc4 ; (nformf.s18 + 0)
.s45:
1fa5 : a9 00 __ LDA #$00
1fa7 : 85 03 __ STA WORK + 0 
1fa9 : 85 04 __ STA WORK + 1 
1fab : 20 be 35 JSR $35be ; (freg@proxy + 0)
1fae : 20 e0 30 JSR $30e0 ; (crt_fdiv + 0)
1fb1 : a5 1c __ LDA ACCU + 1 
1fb3 : 85 12 __ STA P5 ; (f + 1)
1fb5 : a5 1d __ LDA ACCU + 2 
1fb7 : 85 13 __ STA P6 ; (f + 2)
1fb9 : a5 1e __ LDA ACCU + 3 
1fbb : 85 14 __ STA P7 ; (f + 3)
1fbd : a6 4b __ LDX T4 + 0 
1fbf : ca __ __ DEX
1fc0 : 86 50 __ STX T7 + 0 
1fc2 : a6 1b __ LDX ACCU + 0 
.s18:
1fc4 : 38 __ __ SEC
1fc5 : a5 4f __ LDA T6 + 0 
1fc7 : e5 50 __ SBC T7 + 0 
1fc9 : 85 4b __ STA T4 + 0 
1fcb : a9 00 __ LDA #$00
1fcd : e9 00 __ SBC #$00
1fcf : 85 4c __ STA T4 + 1 
1fd1 : a9 14 __ LDA #$14
1fd3 : c5 4f __ CMP T6 + 0 
1fd5 : b0 02 __ BCS $1fd9 ; (nformf.s19 + 0)
.s44:
1fd7 : 85 4f __ STA T6 + 0 
.s19:
1fd9 : a5 4b __ LDA T4 + 0 
1fdb : d0 08 __ BNE $1fe5 ; (nformf.s21 + 0)
.s20:
1fdd : a9 30 __ LDA #$30
1fdf : a4 52 __ LDY T9 + 0 
1fe1 : 91 0f __ STA (P2),y ; (str + 0)
1fe3 : e6 52 __ INC T9 + 0 
.s21:
1fe5 : a9 00 __ LDA #$00
1fe7 : 85 54 __ STA T11 + 0 
1fe9 : c5 4b __ CMP T4 + 0 
1feb : f0 67 __ BEQ $2054 ; (nformf.l43 + 0)
.s23:
1fed : c9 07 __ CMP #$07
1fef : 90 04 __ BCC $1ff5 ; (nformf.s24 + 0)
.l42:
1ff1 : a9 30 __ LDA #$30
1ff3 : b0 4d __ BCS $2042 ; (nformf.l25 + 0)
.s24:
1ff5 : 86 1b __ STX ACCU + 0 
1ff7 : 86 43 __ STX T0 + 0 
1ff9 : a5 12 __ LDA P5 ; (f + 1)
1ffb : 85 1c __ STA ACCU + 1 
1ffd : 85 44 __ STA T0 + 1 
1fff : a5 13 __ LDA P6 ; (f + 2)
2001 : 85 1d __ STA ACCU + 2 
2003 : 85 45 __ STA T0 + 2 
2005 : a5 14 __ LDA P7 ; (f + 3)
2007 : 85 1e __ STA ACCU + 3 
2009 : 85 46 __ STA T0 + 3 
200b : 20 a1 32 JSR $32a1 ; (f32_to_i16 + 0)
200e : a5 1b __ LDA ACCU + 0 
2010 : 85 51 __ STA T8 + 0 
2012 : 20 ed 32 JSR $32ed ; (sint16_to_float + 0)
2015 : a2 43 __ LDX #$43
2017 : 20 ea 2e JSR $2eea ; (freg + 4)
201a : a5 1e __ LDA ACCU + 3 
201c : 49 80 __ EOR #$80
201e : 85 1e __ STA ACCU + 3 
2020 : 20 31 2f JSR $2f31 ; (faddsub + 6)
2023 : a9 00 __ LDA #$00
2025 : 85 03 __ STA WORK + 0 
2027 : 85 04 __ STA WORK + 1 
2029 : 20 be 35 JSR $35be ; (freg@proxy + 0)
202c : 20 18 30 JSR $3018 ; (crt_fmul + 0)
202f : a5 1c __ LDA ACCU + 1 
2031 : 85 12 __ STA P5 ; (f + 1)
2033 : a5 1d __ LDA ACCU + 2 
2035 : 85 13 __ STA P6 ; (f + 2)
2037 : a5 1e __ LDA ACCU + 3 
2039 : 85 14 __ STA P7 ; (f + 3)
203b : 18 __ __ CLC
203c : a5 51 __ LDA T8 + 0 
203e : 69 30 __ ADC #$30
2040 : a6 1b __ LDX ACCU + 0 
.l25:
2042 : a4 52 __ LDY T9 + 0 
2044 : 91 0f __ STA (P2),y ; (str + 0)
2046 : e6 52 __ INC T9 + 0 
2048 : e6 54 __ INC T11 + 0 
204a : a5 54 __ LDA T11 + 0 
204c : c5 4f __ CMP T6 + 0 
204e : b0 14 __ BCS $2064 ; (nformf.s26 + 0)
.s22:
2050 : c5 4b __ CMP T4 + 0 
2052 : d0 99 __ BNE $1fed ; (nformf.s23 + 0)
.l43:
2054 : a9 2e __ LDA #$2e
2056 : a4 52 __ LDY T9 + 0 
2058 : 91 0f __ STA (P2),y ; (str + 0)
205a : e6 52 __ INC T9 + 0 
205c : a5 54 __ LDA T11 + 0 
205e : c9 07 __ CMP #$07
2060 : 90 93 __ BCC $1ff5 ; (nformf.s24 + 0)
2062 : b0 8d __ BCS $1ff1 ; (nformf.l42 + 0)
.s26:
2064 : a5 53 __ LDA T10 + 0 
2066 : f0 66 __ BEQ $20ce ; (nformf.s27 + 0)
.s38:
2068 : a0 03 __ LDY #$03
206a : b1 0d __ LDA (P0),y ; (si + 0)
206c : 69 03 __ ADC #$03
206e : a4 52 __ LDY T9 + 0 
2070 : 91 0f __ STA (P2),y ; (str + 0)
2072 : c8 __ __ INY
2073 : 84 52 __ STY T9 + 0 
2075 : 24 4e __ BIT T5 + 1 
2077 : 30 06 __ BMI $207f ; (nformf.s41 + 0)
.s39:
2079 : a9 2b __ LDA #$2b
207b : 91 0f __ STA (P2),y ; (str + 0)
207d : d0 11 __ BNE $2090 ; (nformf.s40 + 0)
.s41:
207f : a9 2d __ LDA #$2d
2081 : 91 0f __ STA (P2),y ; (str + 0)
2083 : 38 __ __ SEC
2084 : a9 00 __ LDA #$00
2086 : e5 4d __ SBC T5 + 0 
2088 : 85 4d __ STA T5 + 0 
208a : a9 00 __ LDA #$00
208c : e5 4e __ SBC T5 + 1 
208e : 85 4e __ STA T5 + 1 
.s40:
2090 : e6 52 __ INC T9 + 0 
2092 : a5 4d __ LDA T5 + 0 
2094 : 85 1b __ STA ACCU + 0 
2096 : a5 4e __ LDA T5 + 1 
2098 : 85 1c __ STA ACCU + 1 
209a : a9 0a __ LDA #$0a
209c : 85 03 __ STA WORK + 0 
209e : a9 00 __ LDA #$00
20a0 : 85 04 __ STA WORK + 1 
20a2 : 20 8e 31 JSR $318e ; (divs16 + 0)
20a5 : 18 __ __ CLC
20a6 : a5 1b __ LDA ACCU + 0 
20a8 : 69 30 __ ADC #$30
20aa : a4 52 __ LDY T9 + 0 
20ac : 91 0f __ STA (P2),y ; (str + 0)
20ae : e6 52 __ INC T9 + 0 
20b0 : a5 4d __ LDA T5 + 0 
20b2 : 85 1b __ STA ACCU + 0 
20b4 : a5 4e __ LDA T5 + 1 
20b6 : 85 1c __ STA ACCU + 1 
20b8 : a9 0a __ LDA #$0a
20ba : 85 03 __ STA WORK + 0 
20bc : a9 00 __ LDA #$00
20be : 85 04 __ STA WORK + 1 
20c0 : 20 4a 32 JSR $324a ; (mods16 + 0)
20c3 : 18 __ __ CLC
20c4 : a5 05 __ LDA WORK + 2 
20c6 : 69 30 __ ADC #$30
20c8 : a4 52 __ LDY T9 + 0 
20ca : 91 0f __ STA (P2),y ; (str + 0)
20cc : e6 52 __ INC T9 + 0 
.s27:
20ce : a5 52 __ LDA T9 + 0 
20d0 : a0 01 __ LDY #$01
20d2 : d1 0d __ CMP (P0),y ; (si + 0)
20d4 : b0 6d __ BCS $2143 ; (nformf.s3 + 0)
.s28:
20d6 : a0 06 __ LDY #$06
20d8 : b1 0d __ LDA (P0),y ; (si + 0)
20da : f0 04 __ BEQ $20e0 ; (nformf.s29 + 0)
.s108:
20dc : a6 52 __ LDX T9 + 0 
20de : 90 70 __ BCC $2150 ; (nformf.l36 + 0)
.s29:
20e0 : a5 52 __ LDA T9 + 0 
20e2 : f0 40 __ BEQ $2124 ; (nformf.s30 + 0)
.s35:
20e4 : e9 00 __ SBC #$00
20e6 : a8 __ __ TAY
20e7 : a9 00 __ LDA #$00
20e9 : e9 00 __ SBC #$00
20eb : aa __ __ TAX
20ec : 98 __ __ TYA
20ed : 18 __ __ CLC
20ee : 65 0f __ ADC P2 ; (str + 0)
20f0 : 85 43 __ STA T0 + 0 
20f2 : 8a __ __ TXA
20f3 : 65 10 __ ADC P3 ; (str + 1)
20f5 : 85 44 __ STA T0 + 1 
20f7 : a9 01 __ LDA #$01
20f9 : 85 4b __ STA T4 + 0 
20fb : a6 52 __ LDX T9 + 0 
20fd : 38 __ __ SEC
.l109:
20fe : a0 01 __ LDY #$01
2100 : b1 0d __ LDA (P0),y ; (si + 0)
2102 : e5 4b __ SBC T4 + 0 
2104 : 85 47 __ STA T1 + 0 
2106 : a9 00 __ LDA #$00
2108 : e5 4c __ SBC T4 + 1 
210a : 18 __ __ CLC
210b : 65 10 __ ADC P3 ; (str + 1)
210d : 85 48 __ STA T1 + 1 
210f : 88 __ __ DEY
2110 : b1 43 __ LDA (T0 + 0),y 
2112 : a4 0f __ LDY P2 ; (str + 0)
2114 : 91 47 __ STA (T1 + 0),y 
2116 : a5 43 __ LDA T0 + 0 
2118 : d0 02 __ BNE $211c ; (nformf.s112 + 0)
.s111:
211a : c6 44 __ DEC T0 + 1 
.s112:
211c : c6 43 __ DEC T0 + 0 
211e : e6 4b __ INC T4 + 0 
2120 : e4 4b __ CPX T4 + 0 
2122 : b0 da __ BCS $20fe ; (nformf.l109 + 0)
.s30:
2124 : a9 00 __ LDA #$00
2126 : 85 4b __ STA T4 + 0 
2128 : 90 08 __ BCC $2132 ; (nformf.l31 + 0)
.s33:
212a : a9 20 __ LDA #$20
212c : a4 4b __ LDY T4 + 0 
212e : 91 0f __ STA (P2),y ; (str + 0)
2130 : e6 4b __ INC T4 + 0 
.l31:
2132 : a0 01 __ LDY #$01
2134 : b1 0d __ LDA (P0),y ; (si + 0)
2136 : 38 __ __ SEC
2137 : e5 52 __ SBC T9 + 0 
2139 : 90 ef __ BCC $212a ; (nformf.s33 + 0)
.s34:
213b : c5 4b __ CMP T4 + 0 
213d : 90 02 __ BCC $2141 ; (nformf.s32 + 0)
.s110:
213f : d0 e9 __ BNE $212a ; (nformf.s33 + 0)
.s32:
2141 : b1 0d __ LDA (P0),y ; (si + 0)
.s3:
2143 : 85 1b __ STA ACCU + 0 
2145 : ad ed 9f LDA $9fed ; (nformf@stack + 0)
2148 : 85 53 __ STA T10 + 0 
214a : ad ee 9f LDA $9fee ; (nformf@stack + 1)
214d : 85 54 __ STA T11 + 0 
214f : 60 __ __ RTS
.l36:
2150 : 8a __ __ TXA
2151 : a0 01 __ LDY #$01
2153 : d1 0d __ CMP (P0),y ; (si + 0)
2155 : b0 ea __ BCS $2141 ; (nformf.s32 + 0)
.s37:
2157 : a8 __ __ TAY
2158 : a9 20 __ LDA #$20
215a : 91 0f __ STA (P2),y ; (str + 0)
215c : e8 __ __ INX
215d : 90 f1 __ BCC $2150 ; (nformf.l36 + 0)
.s53:
215f : a5 4f __ LDA T6 + 0 
2161 : c9 07 __ CMP #$07
2163 : 90 14 __ BCC $2179 ; (nformf.s62 + 0)
.s54:
2165 : ad 18 37 LDA $3718 ; (fround5[0] + 24)
2168 : 85 47 __ STA T1 + 0 
216a : ad 19 37 LDA $3719 ; (fround5[0] + 25)
216d : 85 48 __ STA T1 + 1 
216f : ad 1a 37 LDA $371a ; (fround5[0] + 26)
2172 : 85 49 __ STA T1 + 2 
2174 : ad 1b 37 LDA $371b ; (fround5[0] + 27)
2177 : b0 15 __ BCS $218e ; (nformf.s55 + 0)
.s62:
2179 : 0a __ __ ASL
217a : 0a __ __ ASL
217b : aa __ __ TAX
217c : bd fc 36 LDA $36fc,x ; (temp_char[0] + 1)
217f : 85 47 __ STA T1 + 0 
2181 : bd fd 36 LDA $36fd,x 
2184 : 85 48 __ STA T1 + 1 
2186 : bd fe 36 LDA $36fe,x 
2189 : 85 49 __ STA T1 + 2 
218b : bd ff 36 LDA $36ff,x 
.s55:
218e : 85 4a __ STA T1 + 3 
2190 : a2 47 __ LDX #$47
2192 : 20 c9 35 JSR $35c9 ; (freg@proxy + 0)
2195 : 20 31 2f JSR $2f31 ; (faddsub + 6)
2198 : a5 1c __ LDA ACCU + 1 
219a : 85 12 __ STA P5 ; (f + 1)
219c : a5 1d __ LDA ACCU + 2 
219e : 85 13 __ STA P6 ; (f + 2)
21a0 : a6 1b __ LDX ACCU + 0 
21a2 : a5 1e __ LDA ACCU + 3 
21a4 : 85 14 __ STA P7 ; (f + 3)
21a6 : 10 03 __ BPL $21ab ; (nformf.s57 + 0)
21a8 : 4c c4 1f JMP $1fc4 ; (nformf.s18 + 0)
.s57:
21ab : c9 41 __ CMP #$41
21ad : d0 0d __ BNE $21bc ; (nformf.s61 + 0)
.s58:
21af : a5 13 __ LDA P6 ; (f + 2)
21b1 : c9 20 __ CMP #$20
21b3 : d0 07 __ BNE $21bc ; (nformf.s61 + 0)
.s59:
21b5 : a5 12 __ LDA P5 ; (f + 1)
21b7 : d0 03 __ BNE $21bc ; (nformf.s61 + 0)
.s60:
21b9 : 8a __ __ TXA
21ba : f0 02 __ BEQ $21be ; (nformf.s56 + 0)
.s61:
21bc : 90 ea __ BCC $21a8 ; (nformf.s55 + 26)
.s56:
21be : a9 00 __ LDA #$00
21c0 : 85 03 __ STA WORK + 0 
21c2 : 85 04 __ STA WORK + 1 
21c4 : 20 be 35 JSR $35be ; (freg@proxy + 0)
21c7 : 20 e0 30 JSR $30e0 ; (crt_fdiv + 0)
21ca : a5 1c __ LDA ACCU + 1 
21cc : 85 12 __ STA P5 ; (f + 1)
21ce : a5 1d __ LDA ACCU + 2 
21d0 : 85 13 __ STA P6 ; (f + 2)
21d2 : a5 1e __ LDA ACCU + 3 
21d4 : 85 14 __ STA P7 ; (f + 3)
21d6 : a6 1b __ LDX ACCU + 0 
21d8 : e6 4d __ INC T5 + 0 
21da : d0 cc __ BNE $21a8 ; (nformf.s55 + 26)
.s115:
21dc : e6 4e __ INC T5 + 1 
21de : 4c c4 1f JMP $1fc4 ; (nformf.s18 + 0)
--------------------------------------------------------------------
21e1 : __ __ __ BYT 6b 3d 25 30 32 78 20 63 3d 25 30 32 78 00       : k=%02x c=%02x.
--------------------------------------------------------------------
21ef : __ __ __ BYT 73 61 76 69 6e 67 2e 2e 2e 00                   : saving....
--------------------------------------------------------------------
clear_line@proxy: ; clear_line@proxy
21f9 : a9 18 __ LDA #$18
21fb : 85 13 __ STA P6 
--------------------------------------------------------------------
clear_line: ; clear_line(u8)->void
; 113, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
21fd : a5 13 __ LDA P6 ; (y + 0)
21ff : 0a __ __ ASL
2200 : 85 1b __ STA ACCU + 0 
2202 : a9 00 __ LDA #$00
2204 : 2a __ __ ROL
2205 : 06 1b __ ASL ACCU + 0 
2207 : 2a __ __ ROL
2208 : aa __ __ TAX
2209 : a5 1b __ LDA ACCU + 0 
220b : 65 13 __ ADC P6 ; (y + 0)
220d : 85 1b __ STA ACCU + 0 
220f : 8a __ __ TXA
2210 : 69 00 __ ADC #$00
2212 : 06 1b __ ASL ACCU + 0 
2214 : 2a __ __ ROL
2215 : 06 1b __ ASL ACCU + 0 
2217 : 2a __ __ ROL
2218 : 06 1b __ ASL ACCU + 0 
221a : 2a __ __ ROL
221b : 69 04 __ ADC #$04
221d : 85 1c __ STA ACCU + 1 
221f : a9 20 __ LDA #$20
2221 : a0 28 __ LDY #$28
.l5:
2223 : 88 __ __ DEY
2224 : 91 1b __ STA (ACCU + 0),y 
2226 : d0 fb __ BNE $2223 ; (clear_line.l5 + 0)
.s3:
2228 : 60 __ __ RTS
--------------------------------------------------------------------
save_settings: ; save_settings()->void
; 165, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
2229 : a9 01 __ LDA #$01
222b : 8d 41 36 STA $3641 ; (uci_target + 0)
222e : a9 9d __ LDA #$9d
2230 : 85 0d __ STA P0 
2232 : a9 13 __ LDA #$13
2234 : 85 0e __ STA P1 
2236 : 20 81 13 JSR $1381 ; (strlen.s4 + 0)
2239 : a5 1b __ LDA ACCU + 0 
223b : 85 43 __ STA T0 + 0 
223d : 18 __ __ CLC
223e : 69 02 __ ADC #$02
2240 : 85 0f __ STA P2 
2242 : 85 1b __ STA ACCU + 0 
2244 : a5 1c __ LDA ACCU + 1 
2246 : 85 44 __ STA T0 + 1 
2248 : 69 00 __ ADC #$00
224a : 85 10 __ STA P3 
224c : 85 1c __ STA ACCU + 1 
224e : 20 29 34 JSR $3429 ; (crt_malloc + 0)
2251 : a5 1b __ LDA ACCU + 0 
2253 : 85 0d __ STA P0 
2255 : a5 1c __ LDA ACCU + 1 
2257 : 85 0e __ STA P1 
2259 : a9 00 __ LDA #$00
225b : a8 __ __ TAY
225c : 91 0d __ STA (P0),y 
225e : a9 09 __ LDA #$09
2260 : c8 __ __ INY
2261 : 91 0d __ STA (P0),y 
2263 : a5 44 __ LDA T0 + 1 
2265 : 30 1d __ BMI $2284 ; (save_settings.s5 + 0)
.s10:
2267 : 05 43 __ ORA T0 + 0 
2269 : f0 19 __ BEQ $2284 ; (save_settings.s5 + 0)
.s8:
226b : a2 00 __ LDX #$00
226d : 18 __ __ CLC
.l12:
226e : 8a __ __ TXA
226f : 69 02 __ ADC #$02
2271 : a8 __ __ TAY
2272 : bd 9d 13 LDA $139d,x 
2275 : 91 0d __ STA (P0),y 
2277 : a9 00 __ LDA #$00
2279 : e8 __ __ INX
227a : c5 44 __ CMP T0 + 1 
227c : 90 f0 __ BCC $226e ; (save_settings.l12 + 0)
.s11:
227e : d0 04 __ BNE $2284 ; (save_settings.s5 + 0)
.s9:
2280 : e4 43 __ CPX T0 + 0 
2282 : 90 ea __ BCC $226e ; (save_settings.l12 + 0)
.s5:
2284 : a9 01 __ LDA #$01
2286 : 8d 41 36 STA $3641 ; (uci_target + 0)
2289 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
228c : 20 f7 34 JSR $34f7 ; (crt_free@proxy + 0)
228f : a9 06 __ LDA #$06
2291 : 85 11 __ STA P4 
2293 : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
2296 : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
2299 : 20 f8 10 JSR $10f8 ; (uci_open_file@proxy + 0)
229c : ad 00 3f LDA $3f00 ; (uci_status[0] + 0)
229f : c9 30 __ CMP #$30
22a1 : d0 07 __ BNE $22aa ; (save_settings.s3 + 0)
.s6:
22a3 : ad 01 3f LDA $3f01 ; (uci_status[0] + 1)
22a6 : c9 30 __ CMP #$30
22a8 : f0 01 __ BEQ $22ab ; (save_settings.s7 + 0)
.s3:
22aa : 60 __ __ RTS
.s7:
22ab : 20 79 13 JSR $1379 ; (strlen@proxy + 0)
22ae : a5 1b __ LDA ACCU + 0 
22b0 : 85 11 __ STA P4 
22b2 : a5 1c __ LDA ACCU + 1 
22b4 : 85 12 __ STA P5 
22b6 : 20 bc 22 JSR $22bc ; (uci_write_file.s4 + 0)
22b9 : 4c 50 13 JMP $1350 ; (uci_close_file.s4 + 0)
--------------------------------------------------------------------
uci_write_file: ; uci_write_file(u8*,i16)->void
; 142, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
22bc : 18 __ __ CLC
22bd : a5 11 __ LDA P4 ; (length + 0)
22bf : 69 04 __ ADC #$04
22c1 : 85 0f __ STA P2 
22c3 : 85 1b __ STA ACCU + 0 
22c5 : a5 12 __ LDA P5 ; (length + 1)
22c7 : 69 00 __ ADC #$00
22c9 : 85 10 __ STA P3 
22cb : 85 1c __ STA ACCU + 1 
22cd : 20 29 34 JSR $3429 ; (crt_malloc + 0)
22d0 : a5 1b __ LDA ACCU + 0 
22d2 : 85 0d __ STA P0 
22d4 : a5 1c __ LDA ACCU + 1 
22d6 : 85 0e __ STA P1 
22d8 : a9 00 __ LDA #$00
22da : a8 __ __ TAY
22db : 91 0d __ STA (P0),y 
22dd : a9 05 __ LDA #$05
22df : c8 __ __ INY
22e0 : 91 0d __ STA (P0),y 
22e2 : a5 11 __ LDA P4 ; (length + 0)
22e4 : c8 __ __ INY
22e5 : 91 0d __ STA (P0),y 
22e7 : c8 __ __ INY
22e8 : a5 12 __ LDA P5 ; (length + 1)
22ea : 91 0d __ STA (P0),y 
22ec : 30 1d __ BMI $230b ; (uci_write_file.s5 + 0)
.s8:
22ee : 05 11 __ ORA P4 ; (length + 0)
22f0 : f0 19 __ BEQ $230b ; (uci_write_file.s5 + 0)
.s6:
22f2 : a2 00 __ LDX #$00
22f4 : 18 __ __ CLC
.l10:
22f5 : 8a __ __ TXA
22f6 : 69 04 __ ADC #$04
22f8 : a8 __ __ TAY
22f9 : bd 42 36 LDA $3642,x ; (server_host[0] + 0)
22fc : 91 0d __ STA (P0),y 
22fe : a9 00 __ LDA #$00
2300 : e8 __ __ INX
2301 : c5 12 __ CMP P5 ; (length + 1)
2303 : 90 f0 __ BCC $22f5 ; (uci_write_file.l10 + 0)
.s9:
2305 : d0 04 __ BNE $230b ; (uci_write_file.s5 + 0)
.s7:
2307 : e4 11 __ CPX P4 ; (length + 0)
2309 : 90 ea __ BCC $22f5 ; (uci_write_file.l10 + 0)
.s5:
230b : a9 01 __ LDA #$01
230d : 8d 41 36 STA $3641 ; (uci_target + 0)
2310 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
2313 : 20 f7 34 JSR $34f7 ; (crt_free@proxy + 0)
2316 : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
2319 : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
231c : 4c 81 11 JMP $1181 ; (uci_accept.s4 + 0)
--------------------------------------------------------------------
231f : __ __ __ BYT 73 61 76 65 64 21 20 63 6f 6e 6e 65 63 74 69 6e : saved! connectin
232f : __ __ __ BYT 67 2e 2e 2e 00                                  : g....
--------------------------------------------------------------------
connect_to_server: ; connect_to_server()->bool
; 187, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
2334 : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
2337 : a9 23 __ LDA #$23
2339 : 85 10 __ STA P3 
233b : a9 88 __ LDA #$88
233d : 85 0f __ STA P2 
233f : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
2342 : 20 96 23 JSR $2396 ; (uci_tcp_connect.s4 + 0)
2345 : 8d ef 36 STA $36ef ; (socket_id + 0)
2348 : ad 00 3f LDA $3f00 ; (uci_status[0] + 0)
234b : c9 30 __ CMP #$30
234d : d0 26 __ BNE $2375 ; (connect_to_server.s5 + 0)
.s6:
234f : ad 01 3f LDA $3f01 ; (uci_status[0] + 1)
2352 : c9 30 __ CMP #$30
2354 : d0 1f __ BNE $2375 ; (connect_to_server.s5 + 0)
.s7:
2356 : ad ef 36 LDA $36ef ; (socket_id + 0)
2359 : 85 11 __ STA P4 
235b : a9 01 __ LDA #$01
235d : 8d f0 36 STA $36f0 ; (connected + 0)
2360 : 20 42 24 JSR $2442 ; (uci_tcp_nextline.s4 + 0)
2363 : 20 fd 21 JSR $21fd ; (clear_line.s4 + 0)
2366 : a9 25 __ LDA #$25
2368 : 85 10 __ STA P3 
236a : a9 16 __ LDA #$16
236c : 85 0f __ STA P2 
236e : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
2371 : a9 01 __ LDA #$01
2373 : d0 10 __ BNE $2385 ; (connect_to_server.s3 + 0)
.s5:
2375 : 20 fd 21 JSR $21fd ; (clear_line.s4 + 0)
2378 : a9 24 __ LDA #$24
237a : 85 10 __ STA P3 
237c : a9 2d __ LDA #$2d
237e : 85 0f __ STA P2 
2380 : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
2383 : a9 00 __ LDA #$00
.s3:
2385 : 85 1b __ STA ACCU + 0 
2387 : 60 __ __ RTS
--------------------------------------------------------------------
2388 : __ __ __ BYT 63 6f 6e 6e 65 63 74 69 6e 67 2e 2e 2e 00       : connecting....
--------------------------------------------------------------------
uci_tcp_connect: ; uci_tcp_connect(const u8*,u16)->u8
; 157, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
2396 : 20 79 13 JSR $1379 ; (strlen@proxy + 0)
2399 : a5 1b __ LDA ACCU + 0 
239b : 85 43 __ STA T0 + 0 
239d : 18 __ __ CLC
239e : 69 05 __ ADC #$05
23a0 : 85 0f __ STA P2 
23a2 : 85 1b __ STA ACCU + 0 
23a4 : a5 1c __ LDA ACCU + 1 
23a6 : 85 44 __ STA T0 + 1 
23a8 : 69 00 __ ADC #$00
23aa : 85 10 __ STA P3 
23ac : 85 1c __ STA ACCU + 1 
23ae : 20 29 34 JSR $3429 ; (crt_malloc + 0)
23b1 : a9 00 __ LDA #$00
23b3 : a8 __ __ TAY
23b4 : 91 1b __ STA (ACCU + 0),y 
23b6 : a9 07 __ LDA #$07
23b8 : c8 __ __ INY
23b9 : 91 1b __ STA (ACCU + 0),y 
23bb : a9 41 __ LDA #$41
23bd : c8 __ __ INY
23be : 91 1b __ STA (ACCU + 0),y 
23c0 : a9 19 __ LDA #$19
23c2 : c8 __ __ INY
23c3 : 91 1b __ STA (ACCU + 0),y 
23c5 : ad 41 36 LDA $3641 ; (uci_target + 0)
23c8 : 85 45 __ STA T6 + 0 
23ca : a5 44 __ LDA T0 + 1 
23cc : 30 1d __ BMI $23eb ; (uci_tcp_connect.s5 + 0)
.s8:
23ce : 05 43 __ ORA T0 + 0 
23d0 : f0 19 __ BEQ $23eb ; (uci_tcp_connect.s5 + 0)
.s6:
23d2 : a2 00 __ LDX #$00
23d4 : 18 __ __ CLC
.l10:
23d5 : 8a __ __ TXA
23d6 : 69 04 __ ADC #$04
23d8 : a8 __ __ TAY
23d9 : bd 42 36 LDA $3642,x ; (server_host[0] + 0)
23dc : 91 1b __ STA (ACCU + 0),y 
23de : a9 00 __ LDA #$00
23e0 : e8 __ __ INX
23e1 : c5 44 __ CMP T0 + 1 
23e3 : 90 f0 __ BCC $23d5 ; (uci_tcp_connect.l10 + 0)
.s9:
23e5 : d0 04 __ BNE $23eb ; (uci_tcp_connect.s5 + 0)
.s7:
23e7 : e4 43 __ CPX T0 + 0 
23e9 : 90 ea __ BCC $23d5 ; (uci_tcp_connect.l10 + 0)
.s5:
23eb : a5 1b __ LDA ACCU + 0 
23ed : 85 0d __ STA P0 
23ef : 18 __ __ CLC
23f0 : 65 43 __ ADC T0 + 0 
23f2 : 85 43 __ STA T0 + 0 
23f4 : a5 1c __ LDA ACCU + 1 
23f6 : 85 0e __ STA P1 
23f8 : 65 44 __ ADC T0 + 1 
23fa : 85 44 __ STA T0 + 1 
23fc : a9 00 __ LDA #$00
23fe : a0 04 __ LDY #$04
2400 : 91 43 __ STA (T0 + 0),y 
2402 : a9 03 __ LDA #$03
2404 : 8d 41 36 STA $3641 ; (uci_target + 0)
2407 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
240a : 20 f7 34 JSR $34f7 ; (crt_free@proxy + 0)
240d : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
2410 : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
2413 : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
2416 : a9 00 __ LDA #$00
2418 : 8d ed 36 STA $36ed ; (uci_data_len + 0)
241b : 8d ee 36 STA $36ee ; (uci_data_len + 1)
241e : 8d eb 36 STA $36eb ; (uci_data_index + 0)
2421 : 8d ec 36 STA $36ec ; (uci_data_index + 1)
2424 : a5 45 __ LDA T6 + 0 
2426 : 8d 41 36 STA $3641 ; (uci_target + 0)
2429 : ad 1c 37 LDA $371c ; (uci_data[0] + 0)
.s3:
242c : 60 __ __ RTS
--------------------------------------------------------------------
242d : __ __ __ BYT 63 6f 6e 6e 65 63 74 20 66 61 69 6c 65 64 21 00 : connect failed!.
--------------------------------------------------------------------
read_line: ; read_line()->void
; 231, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
243d : ad ef 36 LDA $36ef ; (socket_id + 0)
2440 : 85 11 __ STA P4 
--------------------------------------------------------------------
uci_tcp_nextline: ; uci_tcp_nextline(u8,u8*)->void
; 173, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
2442 : a9 00 __ LDA #$00
2444 : 8d 24 3e STA $3e24 ; (line_buffer[0] + 0)
2447 : 85 46 __ STA T2 + 0 
.l5:
2449 : ad eb 36 LDA $36eb ; (uci_data_index + 0)
244c : 85 43 __ STA T0 + 0 
244e : ad ec 36 LDA $36ec ; (uci_data_index + 1)
2451 : 85 44 __ STA T0 + 1 
2453 : cd ee 36 CMP $36ee ; (uci_data_len + 1)
2456 : d0 0a __ BNE $2462 ; (uci_tcp_nextline.s18 + 0)
.s15:
2458 : a5 43 __ LDA T0 + 0 
245a : cd ed 36 CMP $36ed ; (uci_data_len + 0)
.s16:
245d : b0 0a __ BCS $2469 ; (uci_tcp_nextline.l6 + 0)
245f : 4c f2 24 JMP $24f2 ; (uci_tcp_nextline.s14 + 0)
.s18:
2462 : 4d ee 36 EOR $36ee ; (uci_data_len + 1)
2465 : 10 f6 __ BPL $245d ; (uci_tcp_nextline.s16 + 0)
.s17:
2467 : b0 f6 __ BCS $245f ; (uci_tcp_nextline.s16 + 2)
.l6:
2469 : a9 00 __ LDA #$00
246b : 85 10 __ STA P3 
246d : 8d f1 9f STA $9ff1 ; (cmd[0] + 0)
2470 : a9 05 __ LDA #$05
2472 : 85 0f __ STA P2 
2474 : a9 10 __ LDA #$10
2476 : 8d f2 9f STA $9ff2 ; (cmd[0] + 1)
2479 : a5 11 __ LDA P4 ; (socketid + 0)
247b : 8d f3 9f STA $9ff3 ; (cmd[0] + 2)
247e : a9 7c __ LDA #$7c
2480 : 8d f4 9f STA $9ff4 ; (cmd[0] + 3)
2483 : ad 41 36 LDA $3641 ; (uci_target + 0)
2486 : 85 45 __ STA T1 + 0 
2488 : a9 03 __ LDA #$03
248a : 8d f5 9f STA $9ff5 ; (cmd[0] + 4)
248d : 8d 41 36 STA $3641 ; (uci_target + 0)
2490 : a9 f1 __ LDA #$f1
2492 : 85 0d __ STA P0 
2494 : a9 9f __ LDA #$9f
2496 : 85 0e __ STA P1 
2498 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
249b : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
249e : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
24a1 : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
24a4 : a5 45 __ LDA T1 + 0 
24a6 : 8d 41 36 STA $3641 ; (uci_target + 0)
24a9 : ad 1c 37 LDA $371c ; (uci_data[0] + 0)
24ac : 8d ed 36 STA $36ed ; (uci_data_len + 0)
24af : ad 1d 37 LDA $371d ; (uci_data[0] + 1)
24b2 : 8d ee 36 STA $36ee ; (uci_data_len + 1)
24b5 : 0d 1c 37 ORA $371c ; (uci_data[0] + 0)
24b8 : f0 30 __ BEQ $24ea ; (uci_tcp_nextline.s9 + 0)
.s7:
24ba : ae 1d 37 LDX $371d ; (uci_data[0] + 1)
24bd : e8 __ __ INX
24be : d0 06 __ BNE $24c6 ; (uci_tcp_nextline.s8 + 0)
.s13:
24c0 : ae ed 36 LDX $36ed ; (uci_data_len + 0)
24c3 : e8 __ __ INX
24c4 : f0 a3 __ BEQ $2469 ; (uci_tcp_nextline.l6 + 0)
.s8:
24c6 : a9 01 __ LDA #$01
24c8 : 8d eb 36 STA $36eb ; (uci_data_index + 0)
24cb : a9 00 __ LDA #$00
24cd : 8d ec 36 STA $36ec ; (uci_data_index + 1)
24d0 : ad 1e 37 LDA $371e ; (uci_data[0] + 2)
24d3 : f0 15 __ BEQ $24ea ; (uci_tcp_nextline.s9 + 0)
.s10:
24d5 : c9 0a __ CMP #$0a
24d7 : f0 11 __ BEQ $24ea ; (uci_tcp_nextline.s9 + 0)
.s11:
24d9 : c9 0d __ CMP #$0d
24db : d0 03 __ BNE $24e0 ; (uci_tcp_nextline.s12 + 0)
24dd : 4c 49 24 JMP $2449 ; (uci_tcp_nextline.l5 + 0)
.s12:
24e0 : a6 46 __ LDX T2 + 0 
24e2 : 9d 24 3e STA $3e24,x ; (line_buffer[0] + 0)
24e5 : e6 46 __ INC T2 + 0 
24e7 : 4c 49 24 JMP $2449 ; (uci_tcp_nextline.l5 + 0)
.s9:
24ea : a9 00 __ LDA #$00
24ec : a6 46 __ LDX T2 + 0 
24ee : 9d 24 3e STA $3e24,x ; (line_buffer[0] + 0)
.s3:
24f1 : 60 __ __ RTS
.s14:
24f2 : 18 __ __ CLC
24f3 : a5 43 __ LDA T0 + 0 
24f5 : 69 01 __ ADC #$01
24f7 : 8d eb 36 STA $36eb ; (uci_data_index + 0)
24fa : a5 44 __ LDA T0 + 1 
24fc : 69 00 __ ADC #$00
24fe : 8d ec 36 STA $36ec ; (uci_data_index + 1)
2501 : 18 __ __ CLC
2502 : a9 1e __ LDA #$1e
2504 : 65 43 __ ADC T0 + 0 
2506 : 85 43 __ STA T0 + 0 
2508 : a9 37 __ LDA #$37
250a : 65 44 __ ADC T0 + 1 
250c : 85 44 __ STA T0 + 1 
250e : a0 00 __ LDY #$00
2510 : b1 43 __ LDA (T0 + 0),y 
2512 : f0 d6 __ BEQ $24ea ; (uci_tcp_nextline.s9 + 0)
2514 : d0 bf __ BNE $24d5 ; (uci_tcp_nextline.s10 + 0)
--------------------------------------------------------------------
2516 : __ __ __ BYT 63 6f 6e 6e 65 63 74 65 64 21 00                : connected!.
--------------------------------------------------------------------
load_categories: ; load_categories()->void
; 245, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
2521 : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
2524 : a9 26 __ LDA #$26
2526 : 85 10 __ STA P3 
2528 : a9 02 __ LDA #$02
252a : 85 0f __ STA P2 
252c : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
252f : a9 d8 __ LDA #$d8
2531 : 85 14 __ STA P7 
2533 : a9 26 __ LDA #$26
2535 : 85 15 __ STA P8 
2537 : 20 18 26 JSR $2618 ; (send_command.s4 + 0)
253a : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
253d : a9 00 __ LDA #$00
253f : 8d e9 36 STA $36e9 ; (item_count + 0)
2542 : 8d ea 36 STA $36ea ; (item_count + 1)
2545 : 20 dd 26 JSR $26dd ; (atoi@proxy + 0)
2548 : a5 1b __ LDA ACCU + 0 
254a : 8d f1 36 STA $36f1 ; (total_count + 0)
254d : a5 1c __ LDA ACCU + 1 
254f : 8d f2 36 STA $36f2 ; (total_count + 1)
.l5:
2552 : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2555 : ad 24 3e LDA $3e24 ; (line_buffer[0] + 0)
2558 : c9 2e __ CMP #$2e
255a : f0 7c __ BEQ $25d8 ; (load_categories.s8 + 0)
.s6:
255c : 20 8f 27 JSR $278f ; (strchr@proxy + 0)
255f : a5 1c __ LDA ACCU + 1 
2561 : 05 1b __ ORA ACCU + 0 
2563 : f0 62 __ BEQ $25c7 ; (load_categories.s7 + 0)
.s11:
2565 : a5 1c __ LDA ACCU + 1 
2567 : 85 4d __ STA T1 + 1 
2569 : a5 1b __ LDA ACCU + 0 
256b : 85 4c __ STA T1 + 0 
256d : a9 00 __ LDA #$00
256f : a8 __ __ TAY
2570 : 91 1b __ STA (ACCU + 0),y 
2572 : a9 24 __ LDA #$24
2574 : 85 0f __ STA P2 
2576 : a9 3e __ LDA #$3e
2578 : 85 10 __ STA P3 
257a : ad e9 36 LDA $36e9 ; (item_count + 0)
257d : 85 4e __ STA T2 + 0 
257f : 4a __ __ LSR
2580 : 6a __ __ ROR
2581 : 6a __ __ ROR
2582 : aa __ __ TAX
2583 : 29 c0 __ AND #$c0
2585 : 6a __ __ ROR
2586 : 69 00 __ ADC #$00
2588 : 85 4a __ STA T0 + 0 
258a : 85 0d __ STA P0 
258c : 8a __ __ TXA
258d : 29 1f __ AND #$1f
258f : 69 40 __ ADC #$40
2591 : 85 4b __ STA T0 + 1 
2593 : 85 0e __ STA P1 
2595 : 20 c1 27 JSR $27c1 ; (strncpy.s4 + 0)
2598 : a9 00 __ LDA #$00
259a : a0 1f __ LDY #$1f
259c : 91 4a __ STA (T0 + 0),y 
259e : 18 __ __ CLC
259f : a5 4c __ LDA T1 + 0 
25a1 : 69 01 __ ADC #$01
25a3 : 85 0d __ STA P0 
25a5 : a5 4d __ LDA T1 + 1 
25a7 : 69 00 __ ADC #$00
25a9 : 85 0e __ STA P1 
25ab : 20 e5 26 JSR $26e5 ; (atoi.l4 + 0)
25ae : a5 4e __ LDA T2 + 0 
25b0 : 0a __ __ ASL
25b1 : aa __ __ TAX
25b2 : a5 1b __ LDA ACCU + 0 
25b4 : 9d a4 3e STA $3ea4,x ; (item_ids[0] + 0)
25b7 : a5 1c __ LDA ACCU + 1 
25b9 : 9d a5 3e STA $3ea5,x ; (item_ids[0] + 1)
25bc : a6 4e __ LDX T2 + 0 
25be : e8 __ __ INX
25bf : 8e e9 36 STX $36e9 ; (item_count + 0)
25c2 : a9 00 __ LDA #$00
25c4 : 8d ea 36 STA $36ea ; (item_count + 1)
.s7:
25c7 : ad ea 36 LDA $36ea ; (item_count + 1)
25ca : 30 86 __ BMI $2552 ; (load_categories.l5 + 0)
.s10:
25cc : d0 0a __ BNE $25d8 ; (load_categories.s8 + 0)
.s9:
25ce : ad e9 36 LDA $36e9 ; (item_count + 0)
25d1 : c9 14 __ CMP #$14
25d3 : b0 03 __ BCS $25d8 ; (load_categories.s8 + 0)
25d5 : 4c 52 25 JMP $2552 ; (load_categories.l5 + 0)
.s8:
25d8 : a9 00 __ LDA #$00
25da : 8d 62 36 STA $3662 ; (current_page + 0)
25dd : 8d 63 36 STA $3663 ; (current_page + 1)
25e0 : 8d f5 36 STA $36f5 ; (offset + 0)
25e3 : 8d f6 36 STA $36f6 ; (offset + 1)
25e6 : 8d f3 36 STA $36f3 ; (cursor + 0)
25e9 : 8d f4 36 STA $36f4 ; (cursor + 1)
25ec : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
25ef : a9 00 __ LDA #$00
25f1 : 85 0d __ STA P0 
25f3 : a9 18 __ LDA #$18
25f5 : 85 0e __ STA P1 
25f7 : a9 0c __ LDA #$0c
25f9 : 85 0f __ STA P2 
25fb : a9 28 __ LDA #$28
25fd : 85 10 __ STA P3 
25ff : 4c a1 0f JMP $0fa1 ; (print_at.s4 + 0)
--------------------------------------------------------------------
2602 : __ __ __ BYT 6c 6f 61 64 69 6e 67 20 63 61 74 65 67 6f 72 69 : loading categori
2612 : __ __ __ BYT 65 73 2e 2e 2e 00                               : es....
--------------------------------------------------------------------
send_command: ; send_command(const u8*)->void
; 222, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
2618 : ad f0 36 LDA $36f0 ; (connected + 0)
261b : d0 01 __ BNE $261e ; (send_command.s5 + 0)
.s3:
261d : 60 __ __ RTS
.s5:
261e : a5 14 __ LDA P7 ; (cmd + 0)
2620 : 85 12 __ STA P5 
2622 : a5 15 __ LDA P8 ; (cmd + 1)
2624 : 85 13 __ STA P6 
2626 : 20 b6 35 JSR $35b6 ; (uci_socket_write@proxy + 0)
2629 : a9 0a __ LDA #$0a
262b : 8d fb 36 STA $36fb ; (temp_char[0] + 0)
262e : a9 00 __ LDA #$00
2630 : 8d fc 36 STA $36fc ; (temp_char[0] + 1)
2633 : a9 fb __ LDA #$fb
2635 : 85 12 __ STA P5 
2637 : a9 36 __ LDA #$36
2639 : 85 13 __ STA P6 
--------------------------------------------------------------------
uci_socket_write: ; uci_socket_write(u8,const u8*)->void
; 161, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
263b : a5 12 __ LDA P5 ; (data + 0)
263d : 85 0d __ STA P0 
263f : 85 47 __ STA T3 + 0 
2641 : a5 13 __ LDA P6 ; (data + 1)
2643 : 85 0e __ STA P1 
2645 : 85 48 __ STA T3 + 1 
2647 : 20 81 13 JSR $1381 ; (strlen.s4 + 0)
264a : a5 1b __ LDA ACCU + 0 
264c : 85 43 __ STA T0 + 0 
264e : 18 __ __ CLC
264f : 69 03 __ ADC #$03
2651 : 85 0f __ STA P2 
2653 : 85 1b __ STA ACCU + 0 
2655 : a5 1c __ LDA ACCU + 1 
2657 : 85 44 __ STA T0 + 1 
2659 : 69 00 __ ADC #$00
265b : 85 10 __ STA P3 
265d : 85 1c __ STA ACCU + 1 
265f : 20 29 34 JSR $3429 ; (crt_malloc + 0)
2662 : a9 00 __ LDA #$00
2664 : a8 __ __ TAY
2665 : 91 1b __ STA (ACCU + 0),y 
2667 : a9 11 __ LDA #$11
2669 : c8 __ __ INY
266a : 91 1b __ STA (ACCU + 0),y 
266c : a5 11 __ LDA P4 ; (socketid + 0)
266e : c8 __ __ INY
266f : 91 1b __ STA (ACCU + 0),y 
2671 : ad 41 36 LDA $3641 ; (uci_target + 0)
2674 : 85 49 __ STA T6 + 0 
2676 : a5 44 __ LDA T0 + 1 
2678 : 30 2e __ BMI $26a8 ; (uci_socket_write.s5 + 0)
.s8:
267a : 05 43 __ ORA T0 + 0 
267c : f0 2a __ BEQ $26a8 ; (uci_socket_write.s5 + 0)
.s6:
267e : a5 1b __ LDA ACCU + 0 
2680 : 85 45 __ STA T2 + 0 
2682 : a5 1c __ LDA ACCU + 1 
2684 : 85 46 __ STA T2 + 1 
2686 : a6 44 __ LDX T0 + 1 
.l7:
2688 : a0 00 __ LDY #$00
268a : b1 47 __ LDA (T3 + 0),y 
268c : a0 03 __ LDY #$03
268e : 91 45 __ STA (T2 + 0),y 
2690 : e6 45 __ INC T2 + 0 
2692 : d0 02 __ BNE $2696 ; (uci_socket_write.s13 + 0)
.s12:
2694 : e6 46 __ INC T2 + 1 
.s13:
2696 : e6 47 __ INC T3 + 0 
2698 : d0 02 __ BNE $269c ; (uci_socket_write.s15 + 0)
.s14:
269a : e6 48 __ INC T3 + 1 
.s15:
269c : a5 43 __ LDA T0 + 0 
269e : d0 01 __ BNE $26a1 ; (uci_socket_write.s10 + 0)
.s9:
26a0 : ca __ __ DEX
.s10:
26a1 : c6 43 __ DEC T0 + 0 
26a3 : d0 e3 __ BNE $2688 ; (uci_socket_write.l7 + 0)
.s11:
26a5 : 8a __ __ TXA
26a6 : d0 e0 __ BNE $2688 ; (uci_socket_write.l7 + 0)
.s5:
26a8 : a5 1b __ LDA ACCU + 0 
26aa : 85 0d __ STA P0 
26ac : a5 1c __ LDA ACCU + 1 
26ae : 85 0e __ STA P1 
26b0 : a9 03 __ LDA #$03
26b2 : 8d 41 36 STA $3641 ; (uci_target + 0)
26b5 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
26b8 : 20 f7 34 JSR $34f7 ; (crt_free@proxy + 0)
26bb : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
26be : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
26c1 : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
26c4 : a9 00 __ LDA #$00
26c6 : 8d ed 36 STA $36ed ; (uci_data_len + 0)
26c9 : 8d ee 36 STA $36ee ; (uci_data_len + 1)
26cc : 8d eb 36 STA $36eb ; (uci_data_index + 0)
26cf : 8d ec 36 STA $36ec ; (uci_data_index + 1)
26d2 : a5 49 __ LDA T6 + 0 
26d4 : 8d 41 36 STA $3641 ; (uci_target + 0)
.s3:
26d7 : 60 __ __ RTS
--------------------------------------------------------------------
26d8 : __ __ __ BYT 43 41 54 53 00                                  : CATS.
--------------------------------------------------------------------
atoi@proxy: ; atoi@proxy
26dd : a9 27 __ LDA #$27
26df : 85 0d __ STA P0 
26e1 : a9 3e __ LDA #$3e
26e3 : 85 0e __ STA P1 
--------------------------------------------------------------------
atoi: ; atoi(const u8*)->i16
;  30, "/usr/local/include/oscar64/stdlib.h"
.l4:
26e5 : a0 00 __ LDY #$00
26e7 : b1 0d __ LDA (P0),y ; (s + 0)
26e9 : aa __ __ TAX
26ea : a5 0d __ LDA P0 ; (s + 0)
26ec : 85 43 __ STA T0 + 0 
26ee : 18 __ __ CLC
26ef : 69 01 __ ADC #$01
26f1 : 85 0d __ STA P0 ; (s + 0)
26f3 : a5 0e __ LDA P1 ; (s + 1)
26f5 : 85 44 __ STA T0 + 1 
26f7 : 69 00 __ ADC #$00
26f9 : 85 0e __ STA P1 ; (s + 1)
26fb : 8a __ __ TXA
26fc : e0 21 __ CPX #$21
26fe : b0 08 __ BCS $2708 ; (atoi.s5 + 0)
.s16:
2700 : aa __ __ TAX
2701 : d0 e2 __ BNE $26e5 ; (atoi.l4 + 0)
.s17:
2703 : 85 1b __ STA ACCU + 0 
.s3:
2705 : 85 1c __ STA ACCU + 1 
2707 : 60 __ __ RTS
.s5:
2708 : c9 2d __ CMP #$2d
270a : d0 1d __ BNE $2729 ; (atoi.s6 + 0)
.s15:
270c : a9 01 __ LDA #$01
270e : 85 1d __ STA ACCU + 2 
.s14:
2710 : 18 __ __ CLC
2711 : a5 43 __ LDA T0 + 0 
2713 : 69 02 __ ADC #$02
2715 : 85 0d __ STA P0 ; (s + 0)
2717 : a5 44 __ LDA T0 + 1 
2719 : 69 00 __ ADC #$00
271b : 85 0e __ STA P1 ; (s + 1)
271d : a0 01 __ LDY #$01
271f : b1 43 __ LDA (T0 + 0),y 
.s7:
2721 : 85 1c __ STA ACCU + 1 
2723 : a9 00 __ LDA #$00
2725 : 85 43 __ STA T0 + 0 
2727 : f0 08 __ BEQ $2731 ; (atoi.l8 + 0)
.s6:
2729 : 84 1d __ STY ACCU + 2 
272b : c9 2b __ CMP #$2b
272d : d0 f2 __ BNE $2721 ; (atoi.s7 + 0)
272f : f0 df __ BEQ $2710 ; (atoi.s14 + 0)
.l8:
2731 : 85 44 __ STA T0 + 1 
2733 : a5 1c __ LDA ACCU + 1 
2735 : c9 30 __ CMP #$30
2737 : 90 3b __ BCC $2774 ; (atoi.s9 + 0)
.s12:
2739 : c9 3a __ CMP #$3a
273b : b0 37 __ BCS $2774 ; (atoi.s9 + 0)
.s13:
273d : a0 00 __ LDY #$00
273f : b1 0d __ LDA (P0),y ; (s + 0)
2741 : a8 __ __ TAY
2742 : e6 0d __ INC P0 ; (s + 0)
2744 : d0 02 __ BNE $2748 ; (atoi.s19 + 0)
.s18:
2746 : e6 0e __ INC P1 ; (s + 1)
.s19:
2748 : a5 43 __ LDA T0 + 0 
274a : 0a __ __ ASL
274b : 85 1b __ STA ACCU + 0 
274d : a5 44 __ LDA T0 + 1 
274f : 2a __ __ ROL
2750 : 06 1b __ ASL ACCU + 0 
2752 : 2a __ __ ROL
2753 : aa __ __ TAX
2754 : 18 __ __ CLC
2755 : a5 1b __ LDA ACCU + 0 
2757 : 65 43 __ ADC T0 + 0 
2759 : 85 43 __ STA T0 + 0 
275b : 8a __ __ TXA
275c : 65 44 __ ADC T0 + 1 
275e : 06 43 __ ASL T0 + 0 
2760 : 2a __ __ ROL
2761 : aa __ __ TAX
2762 : a5 1c __ LDA ACCU + 1 
2764 : 84 1c __ STY ACCU + 1 
2766 : 38 __ __ SEC
2767 : e9 30 __ SBC #$30
2769 : 18 __ __ CLC
276a : 65 43 __ ADC T0 + 0 
276c : 85 43 __ STA T0 + 0 
276e : 8a __ __ TXA
276f : 69 00 __ ADC #$00
2771 : 4c 31 27 JMP $2731 ; (atoi.l8 + 0)
.s9:
2774 : a5 1d __ LDA ACCU + 2 
2776 : d0 09 __ BNE $2781 ; (atoi.s11 + 0)
.s10:
2778 : a5 43 __ LDA T0 + 0 
277a : 85 1b __ STA ACCU + 0 
277c : a5 44 __ LDA T0 + 1 
277e : 4c 05 27 JMP $2705 ; (atoi.s3 + 0)
.s11:
2781 : 38 __ __ SEC
2782 : a9 00 __ LDA #$00
2784 : e5 43 __ SBC T0 + 0 
2786 : 85 1b __ STA ACCU + 0 
2788 : a9 00 __ LDA #$00
278a : e5 44 __ SBC T0 + 1 
278c : 4c 05 27 JMP $2705 ; (atoi.s3 + 0)
--------------------------------------------------------------------
strchr@proxy: ; strchr@proxy
278f : a9 24 __ LDA #$24
2791 : 85 0d __ STA P0 
2793 : a9 3e __ LDA #$3e
2795 : 85 0e __ STA P1 
2797 : a9 7c __ LDA #$7c
2799 : 85 0f __ STA P2 
279b : a9 00 __ LDA #$00
279d : 85 10 __ STA P3 
--------------------------------------------------------------------
strchr: ; strchr(const u8*,i16)->u8*
;  18, "/usr/local/include/oscar64/string.h"
.l4:
279f : a0 00 __ LDY #$00
27a1 : b1 0d __ LDA (P0),y ; (str + 0)
27a3 : c5 0f __ CMP P2 ; (ch + 0)
27a5 : d0 09 __ BNE $27b0 ; (strchr.s6 + 0)
.s5:
27a7 : a5 0d __ LDA P0 ; (str + 0)
27a9 : 85 1b __ STA ACCU + 0 
27ab : a5 0e __ LDA P1 ; (str + 1)
.s3:
27ad : 85 1c __ STA ACCU + 1 
27af : 60 __ __ RTS
.s6:
27b0 : aa __ __ TAX
27b1 : f0 09 __ BEQ $27bc ; (strchr.s7 + 0)
.s8:
27b3 : e6 0d __ INC P0 ; (str + 0)
27b5 : d0 e8 __ BNE $279f ; (strchr.l4 + 0)
.s9:
27b7 : e6 0e __ INC P1 ; (str + 1)
27b9 : 4c 9f 27 JMP $279f ; (strchr.l4 + 0)
.s7:
27bc : 85 1b __ STA ACCU + 0 
27be : 4c ad 27 JMP $27ad ; (strchr.s3 + 0)
--------------------------------------------------------------------
strncpy: ; strncpy(u8*,const u8*,i16)->void
;   6, "/usr/local/include/oscar64/string.h"
.s4:
27c1 : a9 1e __ LDA #$1e
27c3 : 85 1b __ STA ACCU + 0 
27c5 : a2 00 __ LDX #$00
.l5:
27c7 : a0 00 __ LDY #$00
27c9 : b1 0f __ LDA (P2),y ; (src + 0)
27cb : 91 0d __ STA (P0),y ; (dst + 0)
27cd : e6 0d __ INC P0 ; (dst + 0)
27cf : d0 02 __ BNE $27d3 ; (strncpy.s12 + 0)
.s11:
27d1 : e6 0e __ INC P1 ; (dst + 1)
.s12:
27d3 : 09 00 __ ORA #$00
27d5 : f0 1a __ BEQ $27f1 ; (strncpy.s6 + 0)
.s9:
27d7 : e6 0f __ INC P2 ; (src + 0)
27d9 : d0 02 __ BNE $27dd ; (strncpy.s14 + 0)
.s13:
27db : e6 10 __ INC P3 ; (src + 1)
.s14:
27dd : 8a __ __ TXA
27de : 05 1b __ ORA ACCU + 0 
27e0 : 85 1c __ STA ACCU + 1 
27e2 : 18 __ __ CLC
27e3 : a5 1b __ LDA ACCU + 0 
27e5 : 69 ff __ ADC #$ff
27e7 : 85 1b __ STA ACCU + 0 
27e9 : 8a __ __ TXA
27ea : 69 ff __ ADC #$ff
27ec : aa __ __ TAX
27ed : a5 1c __ LDA ACCU + 1 
27ef : d0 d6 __ BNE $27c7 ; (strncpy.l5 + 0)
.s6:
27f1 : 8a __ __ TXA
27f2 : 30 17 __ BMI $280b ; (strncpy.s3 + 0)
.s8:
27f4 : 05 1b __ ORA ACCU + 0 
27f6 : f0 13 __ BEQ $280b ; (strncpy.s3 + 0)
.s7:
27f8 : a5 0d __ LDA P0 ; (dst + 0)
27fa : 84 0d __ STY P0 ; (dst + 0)
27fc : a8 __ __ TAY
27fd : a6 1b __ LDX ACCU + 0 
.l10:
27ff : a9 00 __ LDA #$00
2801 : 91 0d __ STA (P0),y ; (dst + 0)
2803 : c8 __ __ INY
2804 : d0 02 __ BNE $2808 ; (strncpy.s16 + 0)
.s15:
2806 : e6 0e __ INC P1 ; (dst + 1)
.s16:
2808 : ca __ __ DEX
2809 : d0 f4 __ BNE $27ff ; (strncpy.l10 + 0)
.s3:
280b : 60 __ __ RTS
--------------------------------------------------------------------
280c : __ __ __ BYT 72 65 61 64 79 00                               : ready.
--------------------------------------------------------------------
draw_list: ; draw_list(const u8*)->void
; 557, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
2812 : a2 05 __ LDX #$05
2814 : b5 53 __ LDA T2 + 0,x 
2816 : 9d a8 9f STA $9fa8,x ; (draw_list@stack + 0)
2819 : ca __ __ DEX
281a : 10 f8 __ BPL $2814 ; (draw_list.s1 + 2)
.s4:
281c : a9 00 __ LDA #$00
281e : 85 0d __ STA P0 
2820 : 85 0e __ STA P1 
2822 : 20 27 0f JSR $0f27 ; (clear_screen@proxy + 0)
2825 : ad fe 9f LDA $9ffe ; (sstack + 8)
2828 : 85 0f __ STA P2 
282a : ad ff 9f LDA $9fff ; (sstack + 9)
282d : 85 10 __ STA P3 
282f : 20 15 15 JSR $1515 ; (print_at_color.s4 + 0)
2832 : ad 62 36 LDA $3662 ; (current_page + 0)
2835 : 85 53 __ STA T2 + 0 
2837 : ad 63 36 LDA $3663 ; (current_page + 1)
283a : 85 54 __ STA T2 + 1 
283c : d0 39 __ BNE $2877 ; (draw_list.s5 + 0)
.s26:
283e : a5 53 __ LDA T2 + 0 
2840 : c9 02 __ CMP #$02
2842 : d0 33 __ BNE $2877 ; (draw_list.s5 + 0)
.s25:
2844 : e6 0e __ INC P1 
2846 : a9 7b __ LDA #$7b
2848 : 85 0f __ STA P2 
284a : a9 29 __ LDA #$29
284c : 85 10 __ STA P3 
284e : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
2851 : a9 3e __ LDA #$3e
2853 : 85 10 __ STA P3 
2855 : a9 cc __ LDA #$cc
2857 : 85 0f __ STA P2 
2859 : 20 01 36 JSR $3601 ; (print_at@proxy + 0)
285c : ad f7 36 LDA $36f7 ; (search_query_len + 0)
285f : 18 __ __ CLC
2860 : 69 08 __ ADC #$08
2862 : 85 0d __ STA P0 
2864 : a9 ac __ LDA #$ac
2866 : 85 0f __ STA P2 
2868 : a9 15 __ LDA #$15
286a : 85 10 __ STA P3 
286c : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
286f : a9 02 __ LDA #$02
2871 : 85 53 __ STA T2 + 0 
2873 : a9 00 __ LDA #$00
2875 : 85 54 __ STA T2 + 1 
.s5:
2877 : ad e9 36 LDA $36e9 ; (item_count + 0)
287a : 85 55 __ STA T3 + 0 
287c : ad ea 36 LDA $36ea ; (item_count + 1)
287f : 85 56 __ STA T3 + 1 
2881 : 30 56 __ BMI $28d9 ; (draw_list.s6 + 0)
.s24:
2883 : 05 55 __ ORA T3 + 0 
2885 : f0 52 __ BEQ $28d9 ; (draw_list.s6 + 0)
.s23:
2887 : ad f5 36 LDA $36f5 ; (offset + 0)
288a : 18 __ __ CLC
288b : 69 01 __ ADC #$01
288d : 8d f8 9f STA $9ff8 ; (sstack + 2)
2890 : a9 b0 __ LDA #$b0
2892 : 85 16 __ STA P9 
2894 : a9 9f __ LDA #$9f
2896 : 85 17 __ STA P10 
2898 : a9 84 __ LDA #$84
289a : 8d f6 9f STA $9ff6 ; (sstack + 0)
289d : a9 29 __ LDA #$29
289f : 8d f7 9f STA $9ff7 ; (sstack + 1)
28a2 : ad f6 36 LDA $36f6 ; (offset + 1)
28a5 : 69 00 __ ADC #$00
28a7 : 8d f9 9f STA $9ff9 ; (sstack + 3)
28aa : 18 __ __ CLC
28ab : a5 55 __ LDA T3 + 0 
28ad : 6d f5 36 ADC $36f5 ; (offset + 0)
28b0 : 8d fa 9f STA $9ffa ; (sstack + 4)
28b3 : a5 56 __ LDA T3 + 1 
28b5 : 6d f6 36 ADC $36f6 ; (offset + 1)
28b8 : 8d fb 9f STA $9ffb ; (sstack + 5)
28bb : ad f1 36 LDA $36f1 ; (total_count + 0)
28be : 8d fc 9f STA $9ffc ; (sstack + 6)
28c1 : ad f2 36 LDA $36f2 ; (total_count + 1)
28c4 : 8d fd 9f STA $9ffd ; (sstack + 7)
28c7 : 20 4e 17 JSR $174e ; (sprintf.s1 + 0)
28ca : a9 9f __ LDA #$9f
28cc : 85 10 __ STA P3 
28ce : a9 02 __ LDA #$02
28d0 : 85 0e __ STA P1 
28d2 : a9 b0 __ LDA #$b0
28d4 : 85 0f __ STA P2 
28d6 : 20 dc 35 JSR $35dc ; (print_at@proxy + 0)
.s6:
28d9 : a5 56 __ LDA T3 + 1 
28db : 30 63 __ BMI $2940 ; (draw_list.s7 + 0)
.s22:
28dd : 05 55 __ ORA T3 + 0 
28df : f0 5f __ BEQ $2940 ; (draw_list.s7 + 0)
.s14:
28e1 : a9 00 __ LDA #$00
28e3 : 85 43 __ STA T0 + 0 
28e5 : 18 __ __ CLC
.l15:
28e6 : 69 04 __ ADC #$04
28e8 : 85 0e __ STA P1 
28ea : a5 43 __ LDA T0 + 0 
28ec : 4a __ __ LSR
28ed : 6a __ __ ROR
28ee : 6a __ __ ROR
28ef : aa __ __ TAX
28f0 : 29 c0 __ AND #$c0
28f2 : 6a __ __ ROR
28f3 : 69 00 __ ADC #$00
28f5 : 85 57 __ STA T5 + 0 
28f7 : 85 0f __ STA P2 
28f9 : 8a __ __ TXA
28fa : 29 1f __ AND #$1f
28fc : 69 40 __ ADC #$40
28fe : 85 58 __ STA T5 + 1 
2900 : 85 10 __ STA P3 
2902 : ad f4 36 LDA $36f4 ; (cursor + 1)
2905 : d0 07 __ BNE $290e ; (draw_list.s16 + 0)
.s21:
2907 : a5 43 __ LDA T0 + 0 
2909 : cd f3 36 CMP $36f3 ; (cursor + 0)
290c : f0 0a __ BEQ $2918 ; (draw_list.s20 + 0)
.s16:
290e : a9 02 __ LDA #$02
2910 : 85 0d __ STA P0 
2912 : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
2915 : 4c 26 29 JMP $2926 ; (draw_list.s17 + 0)
.s20:
2918 : 20 0f 36 JSR $360f ; (print_at_color@proxy + 0)
291b : a5 57 __ LDA T5 + 0 
291d : 85 0f __ STA P2 
291f : a5 58 __ LDA T5 + 1 
2921 : 85 10 __ STA P3 
2923 : 20 08 36 JSR $3608 ; (print_at_color@proxy + 0)
.s17:
2926 : 18 __ __ CLC
2927 : a5 0e __ LDA P1 
2929 : 69 fd __ ADC #$fd
292b : 85 43 __ STA T0 + 0 
292d : a5 56 __ LDA T3 + 1 
292f : f0 05 __ BEQ $2936 ; (draw_list.s19 + 0)
.s27:
2931 : a5 43 __ LDA T0 + 0 
2933 : 4c 3c 29 JMP $293c ; (draw_list.s18 + 0)
.s19:
2936 : a5 43 __ LDA T0 + 0 
2938 : c5 55 __ CMP T3 + 0 
293a : b0 04 __ BCS $2940 ; (draw_list.s7 + 0)
.s18:
293c : c9 12 __ CMP #$12
293e : 90 a6 __ BCC $28e6 ; (draw_list.l15 + 0)
.s7:
2940 : a9 00 __ LDA #$00
2942 : 85 0d __ STA P0 
2944 : a9 17 __ LDA #$17
2946 : 85 0e __ STA P1 
2948 : a5 53 __ LDA T2 + 0 
294a : 05 54 __ ORA T2 + 1 
294c : d0 16 __ BNE $2964 ; (draw_list.s8 + 0)
.s13:
294e : a9 29 __ LDA #$29
2950 : a0 90 __ LDY #$90
.s10:
2952 : 84 0f __ STY P2 
2954 : 85 10 __ STA P3 
2956 : 20 a1 0f JSR $0fa1 ; (print_at.s4 + 0)
.s3:
2959 : a2 05 __ LDX #$05
295b : bd a8 9f LDA $9fa8,x ; (draw_list@stack + 0)
295e : 95 53 __ STA T2 + 0,x 
2960 : ca __ __ DEX
2961 : 10 f8 __ BPL $295b ; (draw_list.s3 + 2)
2963 : 60 __ __ RTS
.s8:
2964 : a5 54 __ LDA T2 + 1 
2966 : d0 05 __ BNE $296d ; (draw_list.s9 + 0)
.s12:
2968 : a6 53 __ LDX T2 + 0 
296a : ca __ __ DEX
296b : f0 07 __ BEQ $2974 ; (draw_list.s11 + 0)
.s9:
296d : a9 29 __ LDA #$29
296f : a0 de __ LDY #$de
2971 : 4c 52 29 JMP $2952 ; (draw_list.s10 + 0)
.s11:
2974 : a9 29 __ LDA #$29
2976 : a0 b9 __ LDY #$b9
2978 : 4c 52 29 JMP $2952 ; (draw_list.s10 + 0)
--------------------------------------------------------------------
297b : __ __ __ BYT 73 65 61 72 63 68 3a 20 00                      : search: .
--------------------------------------------------------------------
2984 : __ __ __ BYT 25 64 2d 25 64 20 6f 66 20 25 64 00             : %d-%d of %d.
--------------------------------------------------------------------
2990 : __ __ __ BYT 77 2f 73 3a 6d 6f 76 65 20 65 6e 74 65 72 3a 73 : w/s:move enter:s
29a0 : __ __ __ BYT 65 6c 20 2f 3a 73 65 61 72 63 68 20 63 3a 63 66 : el /:search c:cf
29b0 : __ __ __ BYT 67 20 71 3a 71 75 69 74 00                      : g q:quit.
--------------------------------------------------------------------
29b9 : __ __ __ BYT 77 2f 73 3a 6d 6f 76 65 20 65 6e 74 65 72 3a 72 : w/s:move enter:r
29c9 : __ __ __ BYT 75 6e 20 64 65 6c 3a 62 61 63 6b 20 6e 2f 70 3a : un del:back n/p:
29d9 : __ __ __ BYT 70 61 67 65 00                                  : page.
--------------------------------------------------------------------
29de : __ __ __ BYT 74 79 70 65 20 74 6f 20 73 65 61 72 63 68 20 65 : type to search e
29ee : __ __ __ BYT 6e 74 65 72 3a 72 75 6e 20 64 65 6c 3a 62 61 63 : nter:run del:bac
29fe : __ __ __ BYT 6b 00                                           : k.
--------------------------------------------------------------------
2a00 : __ __ __ BYT 61 73 73 65 6d 62 6c 79 36 34 20 2d 20 63 61 74 : assembly64 - cat
2a10 : __ __ __ BYT 65 67 6f 72 69 65 73 00                         : egories.
--------------------------------------------------------------------
2a18 : __ __ __ BYT 61 73 73 65 6d 62 6c 79 36 34 20 2d 20 73 65 61 : assembly64 - sea
2a28 : __ __ __ BYT 72 63 68 00                                     : rch.
--------------------------------------------------------------------
update_cursor: ; update_cursor(i16,i16)->void
; 549, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
2a2c : 24 18 __ BIT P11 ; (old_cursor + 1)
2a2e : 30 20 __ BMI $2a50 ; (update_cursor.s5 + 0)
.s11:
2a30 : 2c ea 36 BIT $36ea ; (item_count + 1)
2a33 : 30 1b __ BMI $2a50 ; (update_cursor.s5 + 0)
.s15:
2a35 : a5 18 __ LDA P11 ; (old_cursor + 1)
2a37 : cd ea 36 CMP $36ea ; (item_count + 1)
2a3a : d0 40 __ BNE $2a7c ; (update_cursor.s14 + 0)
.s13:
2a3c : a5 17 __ LDA P10 ; (old_cursor + 0)
2a3e : cd e9 36 CMP $36e9 ; (item_count + 0)
2a41 : b0 0d __ BCS $2a50 ; (update_cursor.s5 + 0)
.s12:
2a43 : 85 14 __ STA P7 
2a45 : a5 18 __ LDA P11 ; (old_cursor + 1)
2a47 : 85 15 __ STA P8 
2a49 : a9 00 __ LDA #$00
2a4b : 85 16 __ STA P9 
2a4d : 20 de 14 JSR $14de ; (draw_item.s4 + 0)
.s5:
2a50 : 2c f7 9f BIT $9ff7 ; (sstack + 1)
2a53 : 30 15 __ BMI $2a6a ; (update_cursor.s3 + 0)
.s6:
2a55 : 2c ea 36 BIT $36ea ; (item_count + 1)
2a58 : 30 10 __ BMI $2a6a ; (update_cursor.s3 + 0)
.s10:
2a5a : ad f7 9f LDA $9ff7 ; (sstack + 1)
2a5d : cd ea 36 CMP $36ea ; (item_count + 1)
2a60 : d0 06 __ BNE $2a68 ; (update_cursor.s9 + 0)
.s8:
2a62 : ad f6 9f LDA $9ff6 ; (sstack + 0)
2a65 : cd e9 36 CMP $36e9 ; (item_count + 0)
.s9:
2a68 : 90 01 __ BCC $2a6b ; (update_cursor.s7 + 0)
.s3:
2a6a : 60 __ __ RTS
.s7:
2a6b : ad f6 9f LDA $9ff6 ; (sstack + 0)
2a6e : 85 14 __ STA P7 
2a70 : ad f7 9f LDA $9ff7 ; (sstack + 1)
2a73 : 85 15 __ STA P8 
2a75 : a9 01 __ LDA #$01
2a77 : 85 16 __ STA P9 
2a79 : 4c de 14 JMP $14de ; (draw_item.s4 + 0)
.s14:
2a7c : b0 d2 __ BCS $2a50 ; (update_cursor.s5 + 0)
.s16:
2a7e : a5 17 __ LDA P10 ; (old_cursor + 0)
2a80 : 90 c1 __ BCC $2a43 ; (update_cursor.s12 + 0)
--------------------------------------------------------------------
load_entries: ; load_entries(const u8*,i16)->void
; 281, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
2a82 : a2 07 __ LDX #$07
2a84 : b5 53 __ LDA T0 + 0,x 
2a86 : 9d 86 9f STA $9f86,x ; (load_entries@stack + 0)
2a89 : ca __ __ DEX
2a8a : 10 f8 __ BPL $2a84 ; (load_entries.s1 + 2)
.s4:
2a8c : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
2a8f : a9 2c __ LDA #$2c
2a91 : 85 10 __ STA P3 
2a93 : a9 40 __ LDA #$40
2a95 : 85 0f __ STA P2 
2a97 : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
2a9a : a9 98 __ LDA #$98
2a9c : 85 0d __ STA P0 
2a9e : a9 9f __ LDA #$9f
2aa0 : 85 0e __ STA P1 
2aa2 : a2 ff __ LDX #$ff
.l5:
2aa4 : e8 __ __ INX
2aa5 : bd 4b 2c LDA $2c4b,x 
2aa8 : 9d 98 9f STA $9f98,x ; (cmd[0] + 0)
2aab : d0 f7 __ BNE $2aa4 ; (load_entries.l5 + 0)
.s6:
2aad : a9 80 __ LDA #$80
2aaf : 85 0f __ STA P2 
2ab1 : a9 42 __ LDA #$42
2ab3 : 85 10 __ STA P3 
2ab5 : 20 51 2c JSR $2c51 ; (strcat.s4 + 0)
2ab8 : a9 84 __ LDA #$84
2aba : 85 0f __ STA P2 
2abc : a9 2c __ LDA #$2c
2abe : 85 10 __ STA P3 
2ac0 : 20 51 2c JSR $2c51 ; (strcat.s4 + 0)
2ac3 : ad fe 9f LDA $9ffe ; (sstack + 8)
2ac6 : 85 57 __ STA T3 + 0 
2ac8 : 8d f8 9f STA $9ff8 ; (sstack + 2)
2acb : a9 90 __ LDA #$90
2acd : 85 16 __ STA P9 
2acf : a9 9f __ LDA #$9f
2ad1 : 85 17 __ STA P10 
2ad3 : a9 86 __ LDA #$86
2ad5 : 8d f6 9f STA $9ff6 ; (sstack + 0)
2ad8 : a9 2c __ LDA #$2c
2ada : 8d f7 9f STA $9ff7 ; (sstack + 1)
2add : ad ff 9f LDA $9fff ; (sstack + 9)
2ae0 : 85 58 __ STA T3 + 1 
2ae2 : 8d f9 9f STA $9ff9 ; (sstack + 3)
2ae5 : 20 4e 17 JSR $174e ; (sprintf.s1 + 0)
2ae8 : a9 98 __ LDA #$98
2aea : 85 0d __ STA P0 
2aec : a9 9f __ LDA #$9f
2aee : 85 10 __ STA P3 
2af0 : a9 9f __ LDA #$9f
2af2 : 85 0e __ STA P1 
2af4 : a9 90 __ LDA #$90
2af6 : 85 0f __ STA P2 
2af8 : 20 51 2c JSR $2c51 ; (strcat.s4 + 0)
2afb : a9 89 __ LDA #$89
2afd : 85 0f __ STA P2 
2aff : a9 2c __ LDA #$2c
2b01 : 85 10 __ STA P3 
2b03 : 20 51 2c JSR $2c51 ; (strcat.s4 + 0)
2b06 : a9 98 __ LDA #$98
2b08 : 85 14 __ STA P7 
2b0a : a9 9f __ LDA #$9f
2b0c : 85 15 __ STA P8 
2b0e : 20 18 26 JSR $2618 ; (send_command.s4 + 0)
2b11 : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2b14 : 20 dd 26 JSR $26dd ; (atoi@proxy + 0)
2b17 : a5 1b __ LDA ACCU + 0 
2b19 : 85 55 __ STA T2 + 0 
2b1b : a5 1c __ LDA ACCU + 1 
2b1d : 85 56 __ STA T2 + 1 
2b1f : 20 98 35 JSR $3598 ; (strchr@proxy + 0)
2b22 : a5 1c __ LDA ACCU + 1 
2b24 : 05 1b __ ORA ACCU + 0 
2b26 : f0 1a __ BEQ $2b42 ; (load_entries.s7 + 0)
.s24:
2b28 : 18 __ __ CLC
2b29 : a5 1b __ LDA ACCU + 0 
2b2b : 69 01 __ ADC #$01
2b2d : 85 0d __ STA P0 
2b2f : a5 1c __ LDA ACCU + 1 
2b31 : 69 00 __ ADC #$00
2b33 : 85 0e __ STA P1 
2b35 : 20 e5 26 JSR $26e5 ; (atoi.l4 + 0)
2b38 : a5 1b __ LDA ACCU + 0 
2b3a : 8d f1 36 STA $36f1 ; (total_count + 0)
2b3d : a5 1c __ LDA ACCU + 1 
2b3f : 8d f2 36 STA $36f2 ; (total_count + 1)
.s7:
2b42 : a5 57 __ LDA T3 + 0 
2b44 : 8d f5 36 STA $36f5 ; (offset + 0)
2b47 : a5 58 __ LDA T3 + 1 
2b49 : 8d f6 36 STA $36f6 ; (offset + 1)
2b4c : a9 00 __ LDA #$00
2b4e : 8d e9 36 STA $36e9 ; (item_count + 0)
2b51 : 8d ea 36 STA $36ea ; (item_count + 1)
2b54 : a5 56 __ LDA T2 + 1 
2b56 : 30 3e __ BMI $2b96 ; (load_entries.s8 + 0)
.s23:
2b58 : 05 55 __ ORA T2 + 0 
2b5a : f0 3a __ BEQ $2b96 ; (load_entries.s8 + 0)
.s11:
2b5c : a9 00 __ LDA #$00
2b5e : 85 57 __ STA T3 + 0 
.l12:
2b60 : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2b63 : ad 24 3e LDA $3e24 ; (line_buffer[0] + 0)
2b66 : c9 2e __ CMP #$2e
2b68 : f0 2c __ BEQ $2b96 ; (load_entries.s8 + 0)
.s13:
2b6a : 20 8f 27 JSR $278f ; (strchr@proxy + 0)
2b6d : a5 1c __ LDA ACCU + 1 
2b6f : 05 1b __ ORA ACCU + 0 
2b71 : d0 59 __ BNE $2bcc ; (load_entries.s20 + 0)
.s14:
2b73 : ad e9 36 LDA $36e9 ; (item_count + 0)
2b76 : 85 57 __ STA T3 + 0 
2b78 : ad ea 36 LDA $36ea ; (item_count + 1)
2b7b : 30 e3 __ BMI $2b60 ; (load_entries.l12 + 0)
.s19:
2b7d : d0 17 __ BNE $2b96 ; (load_entries.s8 + 0)
.s18:
2b7f : a5 57 __ LDA T3 + 0 
2b81 : c9 14 __ CMP #$14
2b83 : b0 11 __ BCS $2b96 ; (load_entries.s8 + 0)
.s15:
2b85 : ad ea 36 LDA $36ea ; (item_count + 1)
2b88 : 30 d6 __ BMI $2b60 ; (load_entries.l12 + 0)
.s17:
2b8a : c5 56 __ CMP T2 + 1 
2b8c : 90 d2 __ BCC $2b60 ; (load_entries.l12 + 0)
.s25:
2b8e : d0 06 __ BNE $2b96 ; (load_entries.s8 + 0)
.s16:
2b90 : a5 57 __ LDA T3 + 0 
2b92 : c5 55 __ CMP T2 + 0 
2b94 : 90 ca __ BCC $2b60 ; (load_entries.l12 + 0)
.s8:
2b96 : ad 24 3e LDA $3e24 ; (line_buffer[0] + 0)
2b99 : c9 2e __ CMP #$2e
2b9b : f0 0a __ BEQ $2ba7 ; (load_entries.s9 + 0)
.l10:
2b9d : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2ba0 : ad 24 3e LDA $3e24 ; (line_buffer[0] + 0)
2ba3 : c9 2e __ CMP #$2e
2ba5 : d0 f6 __ BNE $2b9d ; (load_entries.l10 + 0)
.s9:
2ba7 : a9 00 __ LDA #$00
2ba9 : 8d 63 36 STA $3663 ; (current_page + 1)
2bac : 8d f3 36 STA $36f3 ; (cursor + 0)
2baf : 8d f4 36 STA $36f4 ; (cursor + 1)
2bb2 : a9 18 __ LDA #$18
2bb4 : 85 13 __ STA P6 
2bb6 : a9 01 __ LDA #$01
2bb8 : 8d 62 36 STA $3662 ; (current_page + 0)
2bbb : 20 fd 21 JSR $21fd ; (clear_line.s4 + 0)
2bbe : 20 ef 25 JSR $25ef ; (print_at@proxy + 0)
.s3:
2bc1 : a2 07 __ LDX #$07
2bc3 : bd 86 9f LDA $9f86,x ; (load_entries@stack + 0)
2bc6 : 95 53 __ STA T0 + 0,x 
2bc8 : ca __ __ DEX
2bc9 : 10 f8 __ BPL $2bc3 ; (load_entries.s3 + 2)
2bcb : 60 __ __ RTS
.s20:
2bcc : a5 1c __ LDA ACCU + 1 
2bce : 85 5a __ STA T4 + 1 
2bd0 : a5 1b __ LDA ACCU + 0 
2bd2 : 85 59 __ STA T4 + 0 
2bd4 : a9 00 __ LDA #$00
2bd6 : a8 __ __ TAY
2bd7 : 91 1b __ STA (ACCU + 0),y 
2bd9 : 20 ab 35 JSR $35ab ; (atoi@proxy + 0)
2bdc : a5 57 __ LDA T3 + 0 
2bde : 0a __ __ ASL
2bdf : aa __ __ TAX
2be0 : a5 1b __ LDA ACCU + 0 
2be2 : 9d a4 3e STA $3ea4,x ; (item_ids[0] + 0)
2be5 : a5 1c __ LDA ACCU + 1 
2be7 : 9d a5 3e STA $3ea5,x ; (item_ids[0] + 1)
2bea : 18 __ __ CLC
2beb : a5 59 __ LDA T4 + 0 
2bed : 69 01 __ ADC #$01
2bef : 85 59 __ STA T4 + 0 
2bf1 : 85 0d __ STA P0 
2bf3 : a5 5a __ LDA T4 + 1 
2bf5 : 69 00 __ ADC #$00
2bf7 : 85 5a __ STA T4 + 1 
2bf9 : 85 0e __ STA P1 
2bfb : 20 9f 27 JSR $279f ; (strchr.l4 + 0)
2bfe : a5 59 __ LDA T4 + 0 
2c00 : 85 0f __ STA P2 
2c02 : a5 5a __ LDA T4 + 1 
2c04 : 85 10 __ STA P3 
2c06 : a5 1b __ LDA ACCU + 0 
2c08 : 05 1c __ ORA ACCU + 1 
2c0a : f0 05 __ BEQ $2c11 ; (load_entries.s21 + 0)
.s22:
2c0c : a9 00 __ LDA #$00
2c0e : a8 __ __ TAY
2c0f : 91 1b __ STA (ACCU + 0),y 
.s21:
2c11 : a5 57 __ LDA T3 + 0 
2c13 : 4a __ __ LSR
2c14 : 6a __ __ ROR
2c15 : 6a __ __ ROR
2c16 : aa __ __ TAX
2c17 : 29 c0 __ AND #$c0
2c19 : 6a __ __ ROR
2c1a : 69 00 __ ADC #$00
2c1c : 85 53 __ STA T0 + 0 
2c1e : 85 0d __ STA P0 
2c20 : 8a __ __ TXA
2c21 : 29 1f __ AND #$1f
2c23 : 69 40 __ ADC #$40
2c25 : 85 54 __ STA T0 + 1 
2c27 : 85 0e __ STA P1 
2c29 : 20 c1 27 JSR $27c1 ; (strncpy.s4 + 0)
2c2c : a9 00 __ LDA #$00
2c2e : a0 1f __ LDY #$1f
2c30 : 91 53 __ STA (T0 + 0),y 
2c32 : a6 57 __ LDX T3 + 0 
2c34 : e8 __ __ INX
2c35 : 8e e9 36 STX $36e9 ; (item_count + 0)
2c38 : a9 00 __ LDA #$00
2c3a : 8d ea 36 STA $36ea ; (item_count + 1)
2c3d : 4c 73 2b JMP $2b73 ; (load_entries.s14 + 0)
--------------------------------------------------------------------
2c40 : __ __ __ BYT 6c 6f 61 64 69 6e 67 2e 2e 2e 00                : loading....
--------------------------------------------------------------------
2c4b : __ __ __ BYT 4c 49 53 54 20 00                               : LIST .
--------------------------------------------------------------------
strcat: ; strcat(u8*,const u8*)->void
;  14, "/usr/local/include/oscar64/string.h"
.s4:
2c51 : a5 0d __ LDA P0 ; (dst + 0)
2c53 : 85 1b __ STA ACCU + 0 
2c55 : a5 0e __ LDA P1 ; (dst + 1)
2c57 : 85 1c __ STA ACCU + 1 
2c59 : a0 00 __ LDY #$00
2c5b : b1 0d __ LDA (P0),y ; (dst + 0)
2c5d : f0 0f __ BEQ $2c6e ; (strcat.s5 + 0)
.s6:
2c5f : 84 1b __ STY ACCU + 0 
2c61 : a4 0d __ LDY P0 ; (dst + 0)
.l7:
2c63 : c8 __ __ INY
2c64 : d0 02 __ BNE $2c68 ; (strcat.s11 + 0)
.s10:
2c66 : e6 1c __ INC ACCU + 1 
.s11:
2c68 : b1 1b __ LDA (ACCU + 0),y 
2c6a : d0 f7 __ BNE $2c63 ; (strcat.l7 + 0)
.s8:
2c6c : 84 1b __ STY ACCU + 0 
.s5:
2c6e : a8 __ __ TAY
.l9:
2c6f : b1 0f __ LDA (P2),y ; (src + 0)
2c71 : 91 1b __ STA (ACCU + 0),y 
2c73 : aa __ __ TAX
2c74 : e6 0f __ INC P2 ; (src + 0)
2c76 : d0 02 __ BNE $2c7a ; (strcat.s13 + 0)
.s12:
2c78 : e6 10 __ INC P3 ; (src + 1)
.s13:
2c7a : e6 1b __ INC ACCU + 0 
2c7c : d0 02 __ BNE $2c80 ; (strcat.s15 + 0)
.s14:
2c7e : e6 1c __ INC ACCU + 1 
.s15:
2c80 : 8a __ __ TXA
2c81 : d0 ec __ BNE $2c6f ; (strcat.l9 + 0)
.s3:
2c83 : 60 __ __ RTS
--------------------------------------------------------------------
2c84 : __ __ __ BYT 20 00                                           :  .
--------------------------------------------------------------------
2c86 : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
2c89 : __ __ __ BYT 20 32 30 00                                     :  20.
--------------------------------------------------------------------
2c8d : __ __ __ BYT 73 61 76 65 64 21 00                            : saved!.
--------------------------------------------------------------------
run_entry: ; run_entry(i16)->void
; 346, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
2c94 : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
2c97 : a9 2c __ LDA #$2c
2c99 : 85 10 __ STA P3 
2c9b : a9 e7 __ LDA #$e7
2c9d : 85 0f __ STA P2 
2c9f : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
2ca2 : a9 b8 __ LDA #$b8
2ca4 : 85 16 __ STA P9 
2ca6 : a9 f2 __ LDA #$f2
2ca8 : 8d f6 9f STA $9ff6 ; (sstack + 0)
2cab : a9 9f __ LDA #$9f
2cad : 85 17 __ STA P10 
2caf : a9 2c __ LDA #$2c
2cb1 : 8d f7 9f STA $9ff7 ; (sstack + 1)
2cb4 : ad fe 9f LDA $9ffe ; (sstack + 8)
2cb7 : 8d f8 9f STA $9ff8 ; (sstack + 2)
2cba : ad ff 9f LDA $9fff ; (sstack + 9)
2cbd : 8d f9 9f STA $9ff9 ; (sstack + 3)
2cc0 : 20 4e 17 JSR $174e ; (sprintf.s1 + 0)
2cc3 : a9 b8 __ LDA #$b8
2cc5 : 85 14 __ STA P7 
2cc7 : a9 9f __ LDA #$9f
2cc9 : 85 15 __ STA P8 
2ccb : 20 18 26 JSR $2618 ; (send_command.s4 + 0)
2cce : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2cd1 : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
2cd4 : a9 3e __ LDA #$3e
2cd6 : 85 10 __ STA P3 
2cd8 : a9 24 __ LDA #$24
2cda : 85 0f __ STA P2 
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
2cdc : a9 00 __ LDA #$00
2cde : 85 0d __ STA P0 
2ce0 : a9 18 __ LDA #$18
2ce2 : 85 0e __ STA P1 
2ce4 : 4c a1 0f JMP $0fa1 ; (print_at.s4 + 0)
--------------------------------------------------------------------
2ce7 : __ __ __ BYT 72 75 6e 6e 69 6e 67 2e 2e 2e 00                : running....
--------------------------------------------------------------------
2cf2 : __ __ __ BYT 52 55 4e 20 25 64 00                            : RUN %d.
--------------------------------------------------------------------
do_search: ; do_search(const u8*,i16)->void
; 359, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
2cf9 : a2 06 __ LDX #$06
2cfb : b5 53 __ LDA T0 + 0,x 
2cfd : 9d 8e 9f STA $9f8e,x ; (do_search@stack + 0)
2d00 : ca __ __ DEX
2d01 : 10 f8 __ BPL $2cfb ; (do_search.s1 + 2)
.s4:
2d03 : 20 f9 21 JSR $21f9 ; (clear_line@proxy + 0)
2d06 : a9 2e __ LDA #$2e
2d08 : 85 10 __ STA P3 
2d0a : a9 6e __ LDA #$6e
2d0c : 85 0f __ STA P2 
2d0e : 20 dc 2c JSR $2cdc ; (print_at@proxy + 0)
2d11 : a9 00 __ LDA #$00
2d13 : 8d fa 9f STA $9ffa ; (sstack + 4)
2d16 : 8d fb 9f STA $9ffb ; (sstack + 5)
2d19 : a9 98 __ LDA #$98
2d1b : 85 16 __ STA P9 
2d1d : a9 7b __ LDA #$7b
2d1f : 8d f6 9f STA $9ff6 ; (sstack + 0)
2d22 : a9 9f __ LDA #$9f
2d24 : 85 17 __ STA P10 
2d26 : a9 2e __ LDA #$2e
2d28 : 8d f7 9f STA $9ff7 ; (sstack + 1)
2d2b : a9 cc __ LDA #$cc
2d2d : 8d f8 9f STA $9ff8 ; (sstack + 2)
2d30 : a9 3e __ LDA #$3e
2d32 : 8d f9 9f STA $9ff9 ; (sstack + 3)
2d35 : 20 4e 17 JSR $174e ; (sprintf.s1 + 0)
2d38 : a9 98 __ LDA #$98
2d3a : 85 14 __ STA P7 
2d3c : a9 9f __ LDA #$9f
2d3e : 85 15 __ STA P8 
2d40 : 20 18 26 JSR $2618 ; (send_command.s4 + 0)
2d43 : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2d46 : 20 dd 26 JSR $26dd ; (atoi@proxy + 0)
2d49 : a5 1b __ LDA ACCU + 0 
2d4b : 85 55 __ STA T2 + 0 
2d4d : a5 1c __ LDA ACCU + 1 
2d4f : 85 56 __ STA T2 + 1 
2d51 : 20 98 35 JSR $3598 ; (strchr@proxy + 0)
2d54 : a5 1c __ LDA ACCU + 1 
2d56 : 05 1b __ ORA ACCU + 0 
2d58 : f0 1a __ BEQ $2d74 ; (do_search.s5 + 0)
.s22:
2d5a : 18 __ __ CLC
2d5b : a5 1b __ LDA ACCU + 0 
2d5d : 69 01 __ ADC #$01
2d5f : 85 0d __ STA P0 
2d61 : a5 1c __ LDA ACCU + 1 
2d63 : 69 00 __ ADC #$00
2d65 : 85 0e __ STA P1 
2d67 : 20 e5 26 JSR $26e5 ; (atoi.l4 + 0)
2d6a : a5 1b __ LDA ACCU + 0 
2d6c : 8d f1 36 STA $36f1 ; (total_count + 0)
2d6f : a5 1c __ LDA ACCU + 1 
2d71 : 8d f2 36 STA $36f2 ; (total_count + 1)
.s5:
2d74 : a9 00 __ LDA #$00
2d76 : 8d f5 36 STA $36f5 ; (offset + 0)
2d79 : 8d f6 36 STA $36f6 ; (offset + 1)
2d7c : 8d e9 36 STA $36e9 ; (item_count + 0)
2d7f : 8d ea 36 STA $36ea ; (item_count + 1)
2d82 : a5 56 __ LDA T2 + 1 
2d84 : 30 3e __ BMI $2dc4 ; (do_search.s6 + 0)
.s21:
2d86 : 05 55 __ ORA T2 + 0 
2d88 : f0 3a __ BEQ $2dc4 ; (do_search.s6 + 0)
.s9:
2d8a : a9 00 __ LDA #$00
2d8c : 85 57 __ STA T3 + 0 
.l10:
2d8e : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2d91 : ad 24 3e LDA $3e24 ; (line_buffer[0] + 0)
2d94 : c9 2e __ CMP #$2e
2d96 : f0 2c __ BEQ $2dc4 ; (do_search.s6 + 0)
.s11:
2d98 : 20 8f 27 JSR $278f ; (strchr@proxy + 0)
2d9b : a5 1c __ LDA ACCU + 1 
2d9d : 05 1b __ ORA ACCU + 0 
2d9f : d0 59 __ BNE $2dfa ; (do_search.s18 + 0)
.s12:
2da1 : ad e9 36 LDA $36e9 ; (item_count + 0)
2da4 : 85 57 __ STA T3 + 0 
2da6 : ad ea 36 LDA $36ea ; (item_count + 1)
2da9 : 30 e3 __ BMI $2d8e ; (do_search.l10 + 0)
.s17:
2dab : d0 17 __ BNE $2dc4 ; (do_search.s6 + 0)
.s16:
2dad : a5 57 __ LDA T3 + 0 
2daf : c9 14 __ CMP #$14
2db1 : b0 11 __ BCS $2dc4 ; (do_search.s6 + 0)
.s13:
2db3 : ad ea 36 LDA $36ea ; (item_count + 1)
2db6 : 30 d6 __ BMI $2d8e ; (do_search.l10 + 0)
.s15:
2db8 : c5 56 __ CMP T2 + 1 
2dba : 90 d2 __ BCC $2d8e ; (do_search.l10 + 0)
.s23:
2dbc : d0 06 __ BNE $2dc4 ; (do_search.s6 + 0)
.s14:
2dbe : a5 57 __ LDA T3 + 0 
2dc0 : c5 55 __ CMP T2 + 0 
2dc2 : 90 ca __ BCC $2d8e ; (do_search.l10 + 0)
.s6:
2dc4 : ad 24 3e LDA $3e24 ; (line_buffer[0] + 0)
2dc7 : c9 2e __ CMP #$2e
2dc9 : f0 0a __ BEQ $2dd5 ; (do_search.s7 + 0)
.l8:
2dcb : 20 3d 24 JSR $243d ; (read_line.s4 + 0)
2dce : ad 24 3e LDA $3e24 ; (line_buffer[0] + 0)
2dd1 : c9 2e __ CMP #$2e
2dd3 : d0 f6 __ BNE $2dcb ; (do_search.l8 + 0)
.s7:
2dd5 : a9 00 __ LDA #$00
2dd7 : 8d 63 36 STA $3663 ; (current_page + 1)
2dda : 8d f3 36 STA $36f3 ; (cursor + 0)
2ddd : 8d f4 36 STA $36f4 ; (cursor + 1)
2de0 : a9 18 __ LDA #$18
2de2 : 85 13 __ STA P6 
2de4 : a9 02 __ LDA #$02
2de6 : 8d 62 36 STA $3662 ; (current_page + 0)
2de9 : 20 fd 21 JSR $21fd ; (clear_line.s4 + 0)
2dec : 20 ef 25 JSR $25ef ; (print_at@proxy + 0)
.s3:
2def : a2 06 __ LDX #$06
2df1 : bd 8e 9f LDA $9f8e,x ; (do_search@stack + 0)
2df4 : 95 53 __ STA T0 + 0,x 
2df6 : ca __ __ DEX
2df7 : 10 f8 __ BPL $2df1 ; (do_search.s3 + 2)
2df9 : 60 __ __ RTS
.s18:
2dfa : a5 1c __ LDA ACCU + 1 
2dfc : 85 59 __ STA T4 + 1 
2dfe : a5 1b __ LDA ACCU + 0 
2e00 : 85 58 __ STA T4 + 0 
2e02 : a9 00 __ LDA #$00
2e04 : a8 __ __ TAY
2e05 : 91 1b __ STA (ACCU + 0),y 
2e07 : 20 ab 35 JSR $35ab ; (atoi@proxy + 0)
2e0a : a5 57 __ LDA T3 + 0 
2e0c : 0a __ __ ASL
2e0d : aa __ __ TAX
2e0e : a5 1b __ LDA ACCU + 0 
2e10 : 9d a4 3e STA $3ea4,x ; (item_ids[0] + 0)
2e13 : a5 1c __ LDA ACCU + 1 
2e15 : 9d a5 3e STA $3ea5,x ; (item_ids[0] + 1)
2e18 : 18 __ __ CLC
2e19 : a5 58 __ LDA T4 + 0 
2e1b : 69 01 __ ADC #$01
2e1d : 85 58 __ STA T4 + 0 
2e1f : 85 0d __ STA P0 
2e21 : a5 59 __ LDA T4 + 1 
2e23 : 69 00 __ ADC #$00
2e25 : 85 59 __ STA T4 + 1 
2e27 : 85 0e __ STA P1 
2e29 : 20 9f 27 JSR $279f ; (strchr.l4 + 0)
2e2c : a5 58 __ LDA T4 + 0 
2e2e : 85 0f __ STA P2 
2e30 : a5 59 __ LDA T4 + 1 
2e32 : 85 10 __ STA P3 
2e34 : a5 1b __ LDA ACCU + 0 
2e36 : 05 1c __ ORA ACCU + 1 
2e38 : f0 05 __ BEQ $2e3f ; (do_search.s19 + 0)
.s20:
2e3a : a9 00 __ LDA #$00
2e3c : a8 __ __ TAY
2e3d : 91 1b __ STA (ACCU + 0),y 
.s19:
2e3f : a5 57 __ LDA T3 + 0 
2e41 : 4a __ __ LSR
2e42 : 6a __ __ ROR
2e43 : 6a __ __ ROR
2e44 : aa __ __ TAX
2e45 : 29 c0 __ AND #$c0
2e47 : 6a __ __ ROR
2e48 : 69 00 __ ADC #$00
2e4a : 85 53 __ STA T0 + 0 
2e4c : 85 0d __ STA P0 
2e4e : 8a __ __ TXA
2e4f : 29 1f __ AND #$1f
2e51 : 69 40 __ ADC #$40
2e53 : 85 54 __ STA T0 + 1 
2e55 : 85 0e __ STA P1 
2e57 : 20 c1 27 JSR $27c1 ; (strncpy.s4 + 0)
2e5a : a9 00 __ LDA #$00
2e5c : a0 1f __ LDY #$1f
2e5e : 91 53 __ STA (T0 + 0),y 
2e60 : a6 57 __ LDX T3 + 0 
2e62 : e8 __ __ INX
2e63 : 8e e9 36 STX $36e9 ; (item_count + 0)
2e66 : a9 00 __ LDA #$00
2e68 : 8d ea 36 STA $36ea ; (item_count + 1)
2e6b : 4c a1 2d JMP $2da1 ; (do_search.s12 + 0)
--------------------------------------------------------------------
2e6e : __ __ __ BYT 73 65 61 72 63 68 69 6e 67 2e 2e 2e 00          : searching....
--------------------------------------------------------------------
2e7b : __ __ __ BYT 53 45 41 52 43 48 20 25 73 20 25 64 20 32 30 00 : SEARCH %s %d 20.
--------------------------------------------------------------------
disconnect_from_server: ; disconnect_from_server()->void
; 208, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
2e8b : ad f0 36 LDA $36f0 ; (connected + 0)
2e8e : f0 46 __ BEQ $2ed6 ; (disconnect_from_server.s3 + 0)
.s5:
2e90 : a9 d7 __ LDA #$d7
2e92 : 85 12 __ STA P5 
2e94 : a9 2e __ LDA #$2e
2e96 : 85 13 __ STA P6 
2e98 : 20 b6 35 JSR $35b6 ; (uci_socket_write@proxy + 0)
2e9b : a9 00 __ LDA #$00
2e9d : 85 10 __ STA P3 
2e9f : 8d f3 9f STA $9ff3 ; (cmd[0] + 0)
2ea2 : a9 09 __ LDA #$09
2ea4 : 8d f4 9f STA $9ff4 ; (cmd[0] + 1)
2ea7 : a5 11 __ LDA P4 
2ea9 : 8d f5 9f STA $9ff5 ; (cmd[0] + 2)
2eac : ad 41 36 LDA $3641 ; (uci_target + 0)
2eaf : 85 4a __ STA T1 + 0 
2eb1 : a9 03 __ LDA #$03
2eb3 : 85 0f __ STA P2 
2eb5 : 8d 41 36 STA $3641 ; (uci_target + 0)
2eb8 : a9 f3 __ LDA #$f3
2eba : 85 0d __ STA P0 
2ebc : a9 9f __ LDA #$9f
2ebe : 85 0e __ STA P1 
2ec0 : 20 3d 10 JSR $103d ; (uci_sendcommand.s4 + 0)
2ec3 : 20 a2 10 JSR $10a2 ; (uci_readdata.s4 + 0)
2ec6 : 20 cf 10 JSR $10cf ; (uci_readstatus.s4 + 0)
2ec9 : 20 81 11 JSR $1181 ; (uci_accept.s4 + 0)
2ecc : a9 00 __ LDA #$00
2ece : 8d f0 36 STA $36f0 ; (connected + 0)
2ed1 : a5 4a __ LDA T1 + 0 
2ed3 : 8d 41 36 STA $3641 ; (uci_target + 0)
.s3:
2ed6 : 60 __ __ RTS
--------------------------------------------------------------------
2ed7 : __ __ __ BYT 51 55 49 54 0a 00                               : QUIT..
--------------------------------------------------------------------
2edd : __ __ __ BYT 67 6f 6f 64 62 79 65 21 00                      : goodbye!.
--------------------------------------------------------------------
freg: ; freg
2ee6 : b1 19 __ LDA (IP + 0),y 
2ee8 : c8 __ __ INY
2ee9 : aa __ __ TAX
2eea : b5 00 __ LDA $00,x 
2eec : 85 03 __ STA WORK + 0 
2eee : b5 01 __ LDA $01,x 
2ef0 : 85 04 __ STA WORK + 1 
2ef2 : b5 02 __ LDA $02,x 
2ef4 : 85 05 __ STA WORK + 2 
2ef6 : b5 03 __ LDA WORK + 0,x 
2ef8 : 85 06 __ STA WORK + 3 
2efa : a5 05 __ LDA WORK + 2 
2efc : 0a __ __ ASL
2efd : a5 06 __ LDA WORK + 3 
2eff : 2a __ __ ROL
2f00 : 85 08 __ STA WORK + 5 
2f02 : f0 06 __ BEQ $2f0a ; (freg + 36)
2f04 : a5 05 __ LDA WORK + 2 
2f06 : 09 80 __ ORA #$80
2f08 : 85 05 __ STA WORK + 2 
2f0a : a5 1d __ LDA ACCU + 2 
2f0c : 0a __ __ ASL
2f0d : a5 1e __ LDA ACCU + 3 
2f0f : 2a __ __ ROL
2f10 : 85 07 __ STA WORK + 4 
2f12 : f0 06 __ BEQ $2f1a ; (freg + 52)
2f14 : a5 1d __ LDA ACCU + 2 
2f16 : 09 80 __ ORA #$80
2f18 : 85 1d __ STA ACCU + 2 
2f1a : 60 __ __ RTS
2f1b : 06 1e __ ASL ACCU + 3 
2f1d : a5 07 __ LDA WORK + 4 
2f1f : 6a __ __ ROR
2f20 : 85 1e __ STA ACCU + 3 
2f22 : b0 06 __ BCS $2f2a ; (freg + 68)
2f24 : a5 1d __ LDA ACCU + 2 
2f26 : 29 7f __ AND #$7f
2f28 : 85 1d __ STA ACCU + 2 
2f2a : 60 __ __ RTS
--------------------------------------------------------------------
faddsub: ; faddsub
2f2b : a5 06 __ LDA WORK + 3 
2f2d : 49 80 __ EOR #$80
2f2f : 85 06 __ STA WORK + 3 
2f31 : a9 ff __ LDA #$ff
2f33 : c5 07 __ CMP WORK + 4 
2f35 : f0 04 __ BEQ $2f3b ; (faddsub + 16)
2f37 : c5 08 __ CMP WORK + 5 
2f39 : d0 11 __ BNE $2f4c ; (faddsub + 33)
2f3b : a5 1e __ LDA ACCU + 3 
2f3d : 09 7f __ ORA #$7f
2f3f : 85 1e __ STA ACCU + 3 
2f41 : a9 80 __ LDA #$80
2f43 : 85 1d __ STA ACCU + 2 
2f45 : a9 00 __ LDA #$00
2f47 : 85 1b __ STA ACCU + 0 
2f49 : 85 1c __ STA ACCU + 1 
2f4b : 60 __ __ RTS
2f4c : 38 __ __ SEC
2f4d : a5 07 __ LDA WORK + 4 
2f4f : e5 08 __ SBC WORK + 5 
2f51 : f0 38 __ BEQ $2f8b ; (faddsub + 96)
2f53 : aa __ __ TAX
2f54 : b0 25 __ BCS $2f7b ; (faddsub + 80)
2f56 : e0 e9 __ CPX #$e9
2f58 : b0 0e __ BCS $2f68 ; (faddsub + 61)
2f5a : a5 08 __ LDA WORK + 5 
2f5c : 85 07 __ STA WORK + 4 
2f5e : a9 00 __ LDA #$00
2f60 : 85 1b __ STA ACCU + 0 
2f62 : 85 1c __ STA ACCU + 1 
2f64 : 85 1d __ STA ACCU + 2 
2f66 : f0 23 __ BEQ $2f8b ; (faddsub + 96)
2f68 : a5 1d __ LDA ACCU + 2 
2f6a : 4a __ __ LSR
2f6b : 66 1c __ ROR ACCU + 1 
2f6d : 66 1b __ ROR ACCU + 0 
2f6f : e8 __ __ INX
2f70 : d0 f8 __ BNE $2f6a ; (faddsub + 63)
2f72 : 85 1d __ STA ACCU + 2 
2f74 : a5 08 __ LDA WORK + 5 
2f76 : 85 07 __ STA WORK + 4 
2f78 : 4c 8b 2f JMP $2f8b ; (faddsub + 96)
2f7b : e0 18 __ CPX #$18
2f7d : b0 33 __ BCS $2fb2 ; (faddsub + 135)
2f7f : a5 05 __ LDA WORK + 2 
2f81 : 4a __ __ LSR
2f82 : 66 04 __ ROR WORK + 1 
2f84 : 66 03 __ ROR WORK + 0 
2f86 : ca __ __ DEX
2f87 : d0 f8 __ BNE $2f81 ; (faddsub + 86)
2f89 : 85 05 __ STA WORK + 2 
2f8b : a5 1e __ LDA ACCU + 3 
2f8d : 29 80 __ AND #$80
2f8f : 85 1e __ STA ACCU + 3 
2f91 : 45 06 __ EOR WORK + 3 
2f93 : 30 31 __ BMI $2fc6 ; (faddsub + 155)
2f95 : 18 __ __ CLC
2f96 : a5 1b __ LDA ACCU + 0 
2f98 : 65 03 __ ADC WORK + 0 
2f9a : 85 1b __ STA ACCU + 0 
2f9c : a5 1c __ LDA ACCU + 1 
2f9e : 65 04 __ ADC WORK + 1 
2fa0 : 85 1c __ STA ACCU + 1 
2fa2 : a5 1d __ LDA ACCU + 2 
2fa4 : 65 05 __ ADC WORK + 2 
2fa6 : 85 1d __ STA ACCU + 2 
2fa8 : 90 08 __ BCC $2fb2 ; (faddsub + 135)
2faa : 66 1d __ ROR ACCU + 2 
2fac : 66 1c __ ROR ACCU + 1 
2fae : 66 1b __ ROR ACCU + 0 
2fb0 : e6 07 __ INC WORK + 4 
2fb2 : a5 07 __ LDA WORK + 4 
2fb4 : c9 ff __ CMP #$ff
2fb6 : f0 83 __ BEQ $2f3b ; (faddsub + 16)
2fb8 : 4a __ __ LSR
2fb9 : 05 1e __ ORA ACCU + 3 
2fbb : 85 1e __ STA ACCU + 3 
2fbd : b0 06 __ BCS $2fc5 ; (faddsub + 154)
2fbf : a5 1d __ LDA ACCU + 2 
2fc1 : 29 7f __ AND #$7f
2fc3 : 85 1d __ STA ACCU + 2 
2fc5 : 60 __ __ RTS
2fc6 : 38 __ __ SEC
2fc7 : a5 1b __ LDA ACCU + 0 
2fc9 : e5 03 __ SBC WORK + 0 
2fcb : 85 1b __ STA ACCU + 0 
2fcd : a5 1c __ LDA ACCU + 1 
2fcf : e5 04 __ SBC WORK + 1 
2fd1 : 85 1c __ STA ACCU + 1 
2fd3 : a5 1d __ LDA ACCU + 2 
2fd5 : e5 05 __ SBC WORK + 2 
2fd7 : 85 1d __ STA ACCU + 2 
2fd9 : b0 19 __ BCS $2ff4 ; (faddsub + 201)
2fdb : 38 __ __ SEC
2fdc : a9 00 __ LDA #$00
2fde : e5 1b __ SBC ACCU + 0 
2fe0 : 85 1b __ STA ACCU + 0 
2fe2 : a9 00 __ LDA #$00
2fe4 : e5 1c __ SBC ACCU + 1 
2fe6 : 85 1c __ STA ACCU + 1 
2fe8 : a9 00 __ LDA #$00
2fea : e5 1d __ SBC ACCU + 2 
2fec : 85 1d __ STA ACCU + 2 
2fee : a5 1e __ LDA ACCU + 3 
2ff0 : 49 80 __ EOR #$80
2ff2 : 85 1e __ STA ACCU + 3 
2ff4 : a5 1d __ LDA ACCU + 2 
2ff6 : 30 ba __ BMI $2fb2 ; (faddsub + 135)
2ff8 : 05 1c __ ORA ACCU + 1 
2ffa : 05 1b __ ORA ACCU + 0 
2ffc : f0 0f __ BEQ $300d ; (faddsub + 226)
2ffe : c6 07 __ DEC WORK + 4 
3000 : f0 0b __ BEQ $300d ; (faddsub + 226)
3002 : 06 1b __ ASL ACCU + 0 
3004 : 26 1c __ ROL ACCU + 1 
3006 : 26 1d __ ROL ACCU + 2 
3008 : 10 f4 __ BPL $2ffe ; (faddsub + 211)
300a : 4c b2 2f JMP $2fb2 ; (faddsub + 135)
300d : a9 00 __ LDA #$00
300f : 85 1b __ STA ACCU + 0 
3011 : 85 1c __ STA ACCU + 1 
3013 : 85 1d __ STA ACCU + 2 
3015 : 85 1e __ STA ACCU + 3 
3017 : 60 __ __ RTS
--------------------------------------------------------------------
crt_fmul: ; crt_fmul
3018 : a5 1b __ LDA ACCU + 0 
301a : 05 1c __ ORA ACCU + 1 
301c : 05 1d __ ORA ACCU + 2 
301e : f0 0e __ BEQ $302e ; (crt_fmul + 22)
3020 : a5 03 __ LDA WORK + 0 
3022 : 05 04 __ ORA WORK + 1 
3024 : 05 05 __ ORA WORK + 2 
3026 : d0 09 __ BNE $3031 ; (crt_fmul + 25)
3028 : 85 1b __ STA ACCU + 0 
302a : 85 1c __ STA ACCU + 1 
302c : 85 1d __ STA ACCU + 2 
302e : 85 1e __ STA ACCU + 3 
3030 : 60 __ __ RTS
3031 : a5 1e __ LDA ACCU + 3 
3033 : 45 06 __ EOR WORK + 3 
3035 : 29 80 __ AND #$80
3037 : 85 1e __ STA ACCU + 3 
3039 : a9 ff __ LDA #$ff
303b : c5 07 __ CMP WORK + 4 
303d : f0 42 __ BEQ $3081 ; (crt_fmul + 105)
303f : c5 08 __ CMP WORK + 5 
3041 : f0 3e __ BEQ $3081 ; (crt_fmul + 105)
3043 : a9 00 __ LDA #$00
3045 : 85 09 __ STA WORK + 6 
3047 : 85 0a __ STA WORK + 7 
3049 : 85 0b __ STA WORK + 8 
304b : a4 1b __ LDY ACCU + 0 
304d : a5 03 __ LDA WORK + 0 
304f : d0 06 __ BNE $3057 ; (crt_fmul + 63)
3051 : a5 04 __ LDA WORK + 1 
3053 : f0 0a __ BEQ $305f ; (crt_fmul + 71)
3055 : d0 05 __ BNE $305c ; (crt_fmul + 68)
3057 : 20 b2 30 JSR $30b2 ; (crt_fmul8 + 0)
305a : a5 04 __ LDA WORK + 1 
305c : 20 b2 30 JSR $30b2 ; (crt_fmul8 + 0)
305f : a5 05 __ LDA WORK + 2 
3061 : 20 b2 30 JSR $30b2 ; (crt_fmul8 + 0)
3064 : 38 __ __ SEC
3065 : a5 0b __ LDA WORK + 8 
3067 : 30 06 __ BMI $306f ; (crt_fmul + 87)
3069 : 06 09 __ ASL WORK + 6 
306b : 26 0a __ ROL WORK + 7 
306d : 2a __ __ ROL
306e : 18 __ __ CLC
306f : 29 7f __ AND #$7f
3071 : 85 0b __ STA WORK + 8 
3073 : a5 07 __ LDA WORK + 4 
3075 : 65 08 __ ADC WORK + 5 
3077 : 90 19 __ BCC $3092 ; (crt_fmul + 122)
3079 : e9 7f __ SBC #$7f
307b : b0 04 __ BCS $3081 ; (crt_fmul + 105)
307d : c9 ff __ CMP #$ff
307f : d0 15 __ BNE $3096 ; (crt_fmul + 126)
3081 : a5 1e __ LDA ACCU + 3 
3083 : 09 7f __ ORA #$7f
3085 : 85 1e __ STA ACCU + 3 
3087 : a9 80 __ LDA #$80
3089 : 85 1d __ STA ACCU + 2 
308b : a9 00 __ LDA #$00
308d : 85 1b __ STA ACCU + 0 
308f : 85 1c __ STA ACCU + 1 
3091 : 60 __ __ RTS
3092 : e9 7e __ SBC #$7e
3094 : 90 15 __ BCC $30ab ; (crt_fmul + 147)
3096 : 4a __ __ LSR
3097 : 05 1e __ ORA ACCU + 3 
3099 : 85 1e __ STA ACCU + 3 
309b : a9 00 __ LDA #$00
309d : 6a __ __ ROR
309e : 05 0b __ ORA WORK + 8 
30a0 : 85 1d __ STA ACCU + 2 
30a2 : a5 0a __ LDA WORK + 7 
30a4 : 85 1c __ STA ACCU + 1 
30a6 : a5 09 __ LDA WORK + 6 
30a8 : 85 1b __ STA ACCU + 0 
30aa : 60 __ __ RTS
30ab : a9 00 __ LDA #$00
30ad : 85 1e __ STA ACCU + 3 
30af : f0 d8 __ BEQ $3089 ; (crt_fmul + 113)
30b1 : 60 __ __ RTS
--------------------------------------------------------------------
crt_fmul8: ; crt_fmul8
30b2 : 38 __ __ SEC
30b3 : 6a __ __ ROR
30b4 : 90 1e __ BCC $30d4 ; (crt_fmul8 + 34)
30b6 : aa __ __ TAX
30b7 : 18 __ __ CLC
30b8 : 98 __ __ TYA
30b9 : 65 09 __ ADC WORK + 6 
30bb : 85 09 __ STA WORK + 6 
30bd : a5 0a __ LDA WORK + 7 
30bf : 65 1c __ ADC ACCU + 1 
30c1 : 85 0a __ STA WORK + 7 
30c3 : a5 0b __ LDA WORK + 8 
30c5 : 65 1d __ ADC ACCU + 2 
30c7 : 6a __ __ ROR
30c8 : 85 0b __ STA WORK + 8 
30ca : 8a __ __ TXA
30cb : 66 0a __ ROR WORK + 7 
30cd : 66 09 __ ROR WORK + 6 
30cf : 4a __ __ LSR
30d0 : f0 0d __ BEQ $30df ; (crt_fmul8 + 45)
30d2 : b0 e2 __ BCS $30b6 ; (crt_fmul8 + 4)
30d4 : 66 0b __ ROR WORK + 8 
30d6 : 66 0a __ ROR WORK + 7 
30d8 : 66 09 __ ROR WORK + 6 
30da : 4a __ __ LSR
30db : 90 f7 __ BCC $30d4 ; (crt_fmul8 + 34)
30dd : d0 d7 __ BNE $30b6 ; (crt_fmul8 + 4)
30df : 60 __ __ RTS
--------------------------------------------------------------------
crt_fdiv: ; crt_fdiv
30e0 : a5 1b __ LDA ACCU + 0 
30e2 : 05 1c __ ORA ACCU + 1 
30e4 : 05 1d __ ORA ACCU + 2 
30e6 : d0 03 __ BNE $30eb ; (crt_fdiv + 11)
30e8 : 85 1e __ STA ACCU + 3 
30ea : 60 __ __ RTS
30eb : a5 1e __ LDA ACCU + 3 
30ed : 45 06 __ EOR WORK + 3 
30ef : 29 80 __ AND #$80
30f1 : 85 1e __ STA ACCU + 3 
30f3 : a5 08 __ LDA WORK + 5 
30f5 : f0 62 __ BEQ $3159 ; (crt_fdiv + 121)
30f7 : a5 07 __ LDA WORK + 4 
30f9 : c9 ff __ CMP #$ff
30fb : f0 5c __ BEQ $3159 ; (crt_fdiv + 121)
30fd : a9 00 __ LDA #$00
30ff : 85 09 __ STA WORK + 6 
3101 : 85 0a __ STA WORK + 7 
3103 : 85 0b __ STA WORK + 8 
3105 : a2 18 __ LDX #$18
3107 : a5 1b __ LDA ACCU + 0 
3109 : c5 03 __ CMP WORK + 0 
310b : a5 1c __ LDA ACCU + 1 
310d : e5 04 __ SBC WORK + 1 
310f : a5 1d __ LDA ACCU + 2 
3111 : e5 05 __ SBC WORK + 2 
3113 : 90 13 __ BCC $3128 ; (crt_fdiv + 72)
3115 : a5 1b __ LDA ACCU + 0 
3117 : e5 03 __ SBC WORK + 0 
3119 : 85 1b __ STA ACCU + 0 
311b : a5 1c __ LDA ACCU + 1 
311d : e5 04 __ SBC WORK + 1 
311f : 85 1c __ STA ACCU + 1 
3121 : a5 1d __ LDA ACCU + 2 
3123 : e5 05 __ SBC WORK + 2 
3125 : 85 1d __ STA ACCU + 2 
3127 : 38 __ __ SEC
3128 : 26 09 __ ROL WORK + 6 
312a : 26 0a __ ROL WORK + 7 
312c : 26 0b __ ROL WORK + 8 
312e : ca __ __ DEX
312f : f0 0a __ BEQ $313b ; (crt_fdiv + 91)
3131 : 06 1b __ ASL ACCU + 0 
3133 : 26 1c __ ROL ACCU + 1 
3135 : 26 1d __ ROL ACCU + 2 
3137 : b0 dc __ BCS $3115 ; (crt_fdiv + 53)
3139 : 90 cc __ BCC $3107 ; (crt_fdiv + 39)
313b : 38 __ __ SEC
313c : a5 0b __ LDA WORK + 8 
313e : 30 06 __ BMI $3146 ; (crt_fdiv + 102)
3140 : 06 09 __ ASL WORK + 6 
3142 : 26 0a __ ROL WORK + 7 
3144 : 2a __ __ ROL
3145 : 18 __ __ CLC
3146 : 29 7f __ AND #$7f
3148 : 85 0b __ STA WORK + 8 
314a : a5 07 __ LDA WORK + 4 
314c : e5 08 __ SBC WORK + 5 
314e : 90 1a __ BCC $316a ; (crt_fdiv + 138)
3150 : 18 __ __ CLC
3151 : 69 7f __ ADC #$7f
3153 : b0 04 __ BCS $3159 ; (crt_fdiv + 121)
3155 : c9 ff __ CMP #$ff
3157 : d0 15 __ BNE $316e ; (crt_fdiv + 142)
3159 : a5 1e __ LDA ACCU + 3 
315b : 09 7f __ ORA #$7f
315d : 85 1e __ STA ACCU + 3 
315f : a9 80 __ LDA #$80
3161 : 85 1d __ STA ACCU + 2 
3163 : a9 00 __ LDA #$00
3165 : 85 1c __ STA ACCU + 1 
3167 : 85 1b __ STA ACCU + 0 
3169 : 60 __ __ RTS
316a : 69 7f __ ADC #$7f
316c : 90 15 __ BCC $3183 ; (crt_fdiv + 163)
316e : 4a __ __ LSR
316f : 05 1e __ ORA ACCU + 3 
3171 : 85 1e __ STA ACCU + 3 
3173 : a9 00 __ LDA #$00
3175 : 6a __ __ ROR
3176 : 05 0b __ ORA WORK + 8 
3178 : 85 1d __ STA ACCU + 2 
317a : a5 0a __ LDA WORK + 7 
317c : 85 1c __ STA ACCU + 1 
317e : a5 09 __ LDA WORK + 6 
3180 : 85 1b __ STA ACCU + 0 
3182 : 60 __ __ RTS
3183 : a9 00 __ LDA #$00
3185 : 85 1e __ STA ACCU + 3 
3187 : 85 1d __ STA ACCU + 2 
3189 : 85 1c __ STA ACCU + 1 
318b : 85 1b __ STA ACCU + 0 
318d : 60 __ __ RTS
--------------------------------------------------------------------
divs16: ; divs16
318e : 24 1c __ BIT ACCU + 1 
3190 : 10 0d __ BPL $319f ; (divs16 + 17)
3192 : 20 a9 31 JSR $31a9 ; (negaccu + 0)
3195 : 24 04 __ BIT WORK + 1 
3197 : 10 0d __ BPL $31a6 ; (divs16 + 24)
3199 : 20 b7 31 JSR $31b7 ; (negtmp + 0)
319c : 4c c5 31 JMP $31c5 ; (divmod + 0)
319f : 24 04 __ BIT WORK + 1 
31a1 : 10 f9 __ BPL $319c ; (divs16 + 14)
31a3 : 20 b7 31 JSR $31b7 ; (negtmp + 0)
31a6 : 20 c5 31 JSR $31c5 ; (divmod + 0)
--------------------------------------------------------------------
negaccu: ; negaccu
31a9 : 38 __ __ SEC
31aa : a9 00 __ LDA #$00
31ac : e5 1b __ SBC ACCU + 0 
31ae : 85 1b __ STA ACCU + 0 
31b0 : a9 00 __ LDA #$00
31b2 : e5 1c __ SBC ACCU + 1 
31b4 : 85 1c __ STA ACCU + 1 
31b6 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp: ; negtmp
31b7 : 38 __ __ SEC
31b8 : a9 00 __ LDA #$00
31ba : e5 03 __ SBC WORK + 0 
31bc : 85 03 __ STA WORK + 0 
31be : a9 00 __ LDA #$00
31c0 : e5 04 __ SBC WORK + 1 
31c2 : 85 04 __ STA WORK + 1 
31c4 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
31c5 : a5 1c __ LDA ACCU + 1 
31c7 : d0 31 __ BNE $31fa ; (divmod + 53)
31c9 : a5 04 __ LDA WORK + 1 
31cb : d0 1e __ BNE $31eb ; (divmod + 38)
31cd : 85 06 __ STA WORK + 3 
31cf : a2 04 __ LDX #$04
31d1 : 06 1b __ ASL ACCU + 0 
31d3 : 2a __ __ ROL
31d4 : c5 03 __ CMP WORK + 0 
31d6 : 90 02 __ BCC $31da ; (divmod + 21)
31d8 : e5 03 __ SBC WORK + 0 
31da : 26 1b __ ROL ACCU + 0 
31dc : 2a __ __ ROL
31dd : c5 03 __ CMP WORK + 0 
31df : 90 02 __ BCC $31e3 ; (divmod + 30)
31e1 : e5 03 __ SBC WORK + 0 
31e3 : 26 1b __ ROL ACCU + 0 
31e5 : ca __ __ DEX
31e6 : d0 eb __ BNE $31d3 ; (divmod + 14)
31e8 : 85 05 __ STA WORK + 2 
31ea : 60 __ __ RTS
31eb : a5 1b __ LDA ACCU + 0 
31ed : 85 05 __ STA WORK + 2 
31ef : a5 1c __ LDA ACCU + 1 
31f1 : 85 06 __ STA WORK + 3 
31f3 : a9 00 __ LDA #$00
31f5 : 85 1b __ STA ACCU + 0 
31f7 : 85 1c __ STA ACCU + 1 
31f9 : 60 __ __ RTS
31fa : a5 04 __ LDA WORK + 1 
31fc : d0 1f __ BNE $321d ; (divmod + 88)
31fe : a5 03 __ LDA WORK + 0 
3200 : 30 1b __ BMI $321d ; (divmod + 88)
3202 : a9 00 __ LDA #$00
3204 : 85 06 __ STA WORK + 3 
3206 : a2 10 __ LDX #$10
3208 : 06 1b __ ASL ACCU + 0 
320a : 26 1c __ ROL ACCU + 1 
320c : 2a __ __ ROL
320d : c5 03 __ CMP WORK + 0 
320f : 90 02 __ BCC $3213 ; (divmod + 78)
3211 : e5 03 __ SBC WORK + 0 
3213 : 26 1b __ ROL ACCU + 0 
3215 : 26 1c __ ROL ACCU + 1 
3217 : ca __ __ DEX
3218 : d0 f2 __ BNE $320c ; (divmod + 71)
321a : 85 05 __ STA WORK + 2 
321c : 60 __ __ RTS
321d : a9 00 __ LDA #$00
321f : 85 05 __ STA WORK + 2 
3221 : 85 06 __ STA WORK + 3 
3223 : 84 02 __ STY $02 
3225 : a0 10 __ LDY #$10
3227 : 18 __ __ CLC
3228 : 26 1b __ ROL ACCU + 0 
322a : 26 1c __ ROL ACCU + 1 
322c : 26 05 __ ROL WORK + 2 
322e : 26 06 __ ROL WORK + 3 
3230 : 38 __ __ SEC
3231 : a5 05 __ LDA WORK + 2 
3233 : e5 03 __ SBC WORK + 0 
3235 : aa __ __ TAX
3236 : a5 06 __ LDA WORK + 3 
3238 : e5 04 __ SBC WORK + 1 
323a : 90 04 __ BCC $3240 ; (divmod + 123)
323c : 86 05 __ STX WORK + 2 
323e : 85 06 __ STA WORK + 3 
3240 : 88 __ __ DEY
3241 : d0 e5 __ BNE $3228 ; (divmod + 99)
3243 : 26 1b __ ROL ACCU + 0 
3245 : 26 1c __ ROL ACCU + 1 
3247 : a4 02 __ LDY $02 
3249 : 60 __ __ RTS
--------------------------------------------------------------------
mods16: ; mods16
324a : 24 1c __ BIT ACCU + 1 
324c : 10 10 __ BPL $325e ; (mods16 + 20)
324e : 20 a9 31 JSR $31a9 ; (negaccu + 0)
3251 : 24 04 __ BIT WORK + 1 
3253 : 10 03 __ BPL $3258 ; (mods16 + 14)
3255 : 20 b7 31 JSR $31b7 ; (negtmp + 0)
3258 : 20 c5 31 JSR $31c5 ; (divmod + 0)
325b : 4c 93 32 JMP $3293 ; (negtmpb + 0)
325e : 24 04 __ BIT WORK + 1 
3260 : 10 03 __ BPL $3265 ; (mods16 + 27)
3262 : 20 b7 31 JSR $31b7 ; (negtmp + 0)
3265 : 4c c5 31 JMP $31c5 ; (divmod + 0)
3268 : 60 __ __ RTS
--------------------------------------------------------------------
negtmpb: ; negtmpb
3293 : 38 __ __ SEC
3294 : a9 00 __ LDA #$00
3296 : e5 05 __ SBC WORK + 2 
3298 : 85 05 __ STA WORK + 2 
329a : a9 00 __ LDA #$00
329c : e5 06 __ SBC WORK + 3 
329e : 85 06 __ STA WORK + 3 
32a0 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16: ; f32_to_i16
32a1 : 20 0a 2f JSR $2f0a ; (freg + 36)
32a4 : a5 07 __ LDA WORK + 4 
32a6 : c9 7f __ CMP #$7f
32a8 : b0 07 __ BCS $32b1 ; (f32_to_i16 + 16)
32aa : a9 00 __ LDA #$00
32ac : 85 1b __ STA ACCU + 0 
32ae : 85 1c __ STA ACCU + 1 
32b0 : 60 __ __ RTS
32b1 : e9 8e __ SBC #$8e
32b3 : 90 16 __ BCC $32cb ; (f32_to_i16 + 42)
32b5 : 24 1e __ BIT ACCU + 3 
32b7 : 30 09 __ BMI $32c2 ; (f32_to_i16 + 33)
32b9 : a9 ff __ LDA #$ff
32bb : 85 1b __ STA ACCU + 0 
32bd : a9 7f __ LDA #$7f
32bf : 85 1c __ STA ACCU + 1 
32c1 : 60 __ __ RTS
32c2 : a9 00 __ LDA #$00
32c4 : 85 1b __ STA ACCU + 0 
32c6 : a9 80 __ LDA #$80
32c8 : 85 1c __ STA ACCU + 1 
32ca : 60 __ __ RTS
32cb : aa __ __ TAX
32cc : a5 1c __ LDA ACCU + 1 
32ce : 46 1d __ LSR ACCU + 2 
32d0 : 6a __ __ ROR
32d1 : e8 __ __ INX
32d2 : d0 fa __ BNE $32ce ; (f32_to_i16 + 45)
32d4 : 24 1e __ BIT ACCU + 3 
32d6 : 10 0e __ BPL $32e6 ; (f32_to_i16 + 69)
32d8 : 38 __ __ SEC
32d9 : 49 ff __ EOR #$ff
32db : 69 00 __ ADC #$00
32dd : 85 1b __ STA ACCU + 0 
32df : a9 00 __ LDA #$00
32e1 : e5 1d __ SBC ACCU + 2 
32e3 : 85 1c __ STA ACCU + 1 
32e5 : 60 __ __ RTS
32e6 : 85 1b __ STA ACCU + 0 
32e8 : a5 1d __ LDA ACCU + 2 
32ea : 85 1c __ STA ACCU + 1 
32ec : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float: ; sint16_to_float
32ed : 24 1c __ BIT ACCU + 1 
32ef : 30 03 __ BMI $32f4 ; (sint16_to_float + 7)
32f1 : 4c 0b 33 JMP $330b ; (uint16_to_float + 0)
32f4 : 38 __ __ SEC
32f5 : a9 00 __ LDA #$00
32f7 : e5 1b __ SBC ACCU + 0 
32f9 : 85 1b __ STA ACCU + 0 
32fb : a9 00 __ LDA #$00
32fd : e5 1c __ SBC ACCU + 1 
32ff : 85 1c __ STA ACCU + 1 
3301 : 20 0b 33 JSR $330b ; (uint16_to_float + 0)
3304 : a5 1e __ LDA ACCU + 3 
3306 : 09 80 __ ORA #$80
3308 : 85 1e __ STA ACCU + 3 
330a : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float: ; uint16_to_float
330b : a5 1b __ LDA ACCU + 0 
330d : 05 1c __ ORA ACCU + 1 
330f : d0 05 __ BNE $3316 ; (uint16_to_float + 11)
3311 : 85 1d __ STA ACCU + 2 
3313 : 85 1e __ STA ACCU + 3 
3315 : 60 __ __ RTS
3316 : a2 8e __ LDX #$8e
3318 : a5 1c __ LDA ACCU + 1 
331a : 30 06 __ BMI $3322 ; (uint16_to_float + 23)
331c : ca __ __ DEX
331d : 06 1b __ ASL ACCU + 0 
331f : 2a __ __ ROL
3320 : 10 fa __ BPL $331c ; (uint16_to_float + 17)
3322 : 0a __ __ ASL
3323 : 85 1d __ STA ACCU + 2 
3325 : a5 1b __ LDA ACCU + 0 
3327 : 85 1c __ STA ACCU + 1 
3329 : 8a __ __ TXA
332a : 4a __ __ LSR
332b : 85 1e __ STA ACCU + 3 
332d : a9 00 __ LDA #$00
332f : 85 1b __ STA ACCU + 0 
3331 : 66 1d __ ROR ACCU + 2 
3333 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32: ; divmod32
3352 : 84 02 __ STY $02 
3354 : a0 20 __ LDY #$20
3356 : a9 00 __ LDA #$00
3358 : 85 07 __ STA WORK + 4 
335a : 85 08 __ STA WORK + 5 
335c : 85 09 __ STA WORK + 6 
335e : 85 0a __ STA WORK + 7 
3360 : a5 05 __ LDA WORK + 2 
3362 : 05 06 __ ORA WORK + 3 
3364 : d0 78 __ BNE $33de ; (divmod32 + 140)
3366 : a5 04 __ LDA WORK + 1 
3368 : d0 27 __ BNE $3391 ; (divmod32 + 63)
336a : 18 __ __ CLC
336b : 26 1b __ ROL ACCU + 0 
336d : 26 1c __ ROL ACCU + 1 
336f : 26 1d __ ROL ACCU + 2 
3371 : 26 1e __ ROL ACCU + 3 
3373 : 2a __ __ ROL
3374 : 90 05 __ BCC $337b ; (divmod32 + 41)
3376 : e5 03 __ SBC WORK + 0 
3378 : 38 __ __ SEC
3379 : b0 06 __ BCS $3381 ; (divmod32 + 47)
337b : c5 03 __ CMP WORK + 0 
337d : 90 02 __ BCC $3381 ; (divmod32 + 47)
337f : e5 03 __ SBC WORK + 0 
3381 : 88 __ __ DEY
3382 : d0 e7 __ BNE $336b ; (divmod32 + 25)
3384 : 85 07 __ STA WORK + 4 
3386 : 26 1b __ ROL ACCU + 0 
3388 : 26 1c __ ROL ACCU + 1 
338a : 26 1d __ ROL ACCU + 2 
338c : 26 1e __ ROL ACCU + 3 
338e : a4 02 __ LDY $02 
3390 : 60 __ __ RTS
3391 : a5 1e __ LDA ACCU + 3 
3393 : d0 10 __ BNE $33a5 ; (divmod32 + 83)
3395 : a6 1d __ LDX ACCU + 2 
3397 : 86 1e __ STX ACCU + 3 
3399 : a6 1c __ LDX ACCU + 1 
339b : 86 1d __ STX ACCU + 2 
339d : a6 1b __ LDX ACCU + 0 
339f : 86 1c __ STX ACCU + 1 
33a1 : 85 1b __ STA ACCU + 0 
33a3 : a0 18 __ LDY #$18
33a5 : 18 __ __ CLC
33a6 : 26 1b __ ROL ACCU + 0 
33a8 : 26 1c __ ROL ACCU + 1 
33aa : 26 1d __ ROL ACCU + 2 
33ac : 26 1e __ ROL ACCU + 3 
33ae : 26 07 __ ROL WORK + 4 
33b0 : 26 08 __ ROL WORK + 5 
33b2 : 90 0c __ BCC $33c0 ; (divmod32 + 110)
33b4 : a5 07 __ LDA WORK + 4 
33b6 : e5 03 __ SBC WORK + 0 
33b8 : aa __ __ TAX
33b9 : a5 08 __ LDA WORK + 5 
33bb : e5 04 __ SBC WORK + 1 
33bd : 38 __ __ SEC
33be : b0 0c __ BCS $33cc ; (divmod32 + 122)
33c0 : 38 __ __ SEC
33c1 : a5 07 __ LDA WORK + 4 
33c3 : e5 03 __ SBC WORK + 0 
33c5 : aa __ __ TAX
33c6 : a5 08 __ LDA WORK + 5 
33c8 : e5 04 __ SBC WORK + 1 
33ca : 90 04 __ BCC $33d0 ; (divmod32 + 126)
33cc : 86 07 __ STX WORK + 4 
33ce : 85 08 __ STA WORK + 5 
33d0 : 88 __ __ DEY
33d1 : d0 d3 __ BNE $33a6 ; (divmod32 + 84)
33d3 : 26 1b __ ROL ACCU + 0 
33d5 : 26 1c __ ROL ACCU + 1 
33d7 : 26 1d __ ROL ACCU + 2 
33d9 : 26 1e __ ROL ACCU + 3 
33db : a4 02 __ LDY $02 
33dd : 60 __ __ RTS
33de : a0 10 __ LDY #$10
33e0 : a5 1e __ LDA ACCU + 3 
33e2 : 85 08 __ STA WORK + 5 
33e4 : a5 1d __ LDA ACCU + 2 
33e6 : 85 07 __ STA WORK + 4 
33e8 : a9 00 __ LDA #$00
33ea : 85 1d __ STA ACCU + 2 
33ec : 85 1e __ STA ACCU + 3 
33ee : 18 __ __ CLC
33ef : 26 1b __ ROL ACCU + 0 
33f1 : 26 1c __ ROL ACCU + 1 
33f3 : 26 07 __ ROL WORK + 4 
33f5 : 26 08 __ ROL WORK + 5 
33f7 : 26 09 __ ROL WORK + 6 
33f9 : 26 0a __ ROL WORK + 7 
33fb : a5 07 __ LDA WORK + 4 
33fd : c5 03 __ CMP WORK + 0 
33ff : a5 08 __ LDA WORK + 5 
3401 : e5 04 __ SBC WORK + 1 
3403 : a5 09 __ LDA WORK + 6 
3405 : e5 05 __ SBC WORK + 2 
3407 : aa __ __ TAX
3408 : a5 0a __ LDA WORK + 7 
340a : e5 06 __ SBC WORK + 3 
340c : 90 11 __ BCC $341f ; (divmod32 + 205)
340e : 86 09 __ STX WORK + 6 
3410 : 85 0a __ STA WORK + 7 
3412 : a5 07 __ LDA WORK + 4 
3414 : e5 03 __ SBC WORK + 0 
3416 : 85 07 __ STA WORK + 4 
3418 : a5 08 __ LDA WORK + 5 
341a : e5 04 __ SBC WORK + 1 
341c : 85 08 __ STA WORK + 5 
341e : 38 __ __ SEC
341f : 88 __ __ DEY
3420 : d0 cd __ BNE $33ef ; (divmod32 + 157)
3422 : 26 1b __ ROL ACCU + 0 
3424 : 26 1c __ ROL ACCU + 1 
3426 : a4 02 __ LDY $02 
3428 : 60 __ __ RTS
--------------------------------------------------------------------
crt_malloc: ; crt_malloc
3429 : 18 __ __ CLC
342a : a5 1b __ LDA ACCU + 0 
342c : 69 05 __ ADC #$05
342e : 29 fc __ AND #$fc
3430 : 85 03 __ STA WORK + 0 
3432 : a5 1c __ LDA ACCU + 1 
3434 : 69 00 __ ADC #$00
3436 : 85 04 __ STA WORK + 1 
3438 : ad ee 3e LDA $3eee ; (HeapNode.end + 0)
343b : d0 26 __ BNE $3463 ; (crt_malloc + 58)
343d : a9 00 __ LDA #$00
343f : 8d a2 42 STA $42a2 
3442 : 8d a3 42 STA $42a3 
3445 : ee ee 3e INC $3eee ; (HeapNode.end + 0)
3448 : a9 a0 __ LDA #$a0
344a : 09 02 __ ORA #$02
344c : 8d ec 3e STA $3eec ; (HeapNode.next + 0)
344f : a9 42 __ LDA #$42
3451 : 8d ed 3e STA $3eed ; (HeapNode.next + 1)
3454 : 38 __ __ SEC
3455 : a9 00 __ LDA #$00
3457 : e9 02 __ SBC #$02
3459 : 8d a4 42 STA $42a4 
345c : a9 90 __ LDA #$90
345e : e9 00 __ SBC #$00
3460 : 8d a5 42 STA $42a5 
3463 : a9 ec __ LDA #$ec
3465 : a2 3e __ LDX #$3e
3467 : 85 1d __ STA ACCU + 2 
3469 : 86 1e __ STX ACCU + 3 
346b : 18 __ __ CLC
346c : a0 00 __ LDY #$00
346e : b1 1d __ LDA (ACCU + 2),y 
3470 : 85 1b __ STA ACCU + 0 
3472 : 65 03 __ ADC WORK + 0 
3474 : 85 05 __ STA WORK + 2 
3476 : c8 __ __ INY
3477 : b1 1d __ LDA (ACCU + 2),y 
3479 : 85 1c __ STA ACCU + 1 
347b : f0 20 __ BEQ $349d ; (crt_malloc + 116)
347d : 65 04 __ ADC WORK + 1 
347f : 85 06 __ STA WORK + 3 
3481 : b0 14 __ BCS $3497 ; (crt_malloc + 110)
3483 : a0 02 __ LDY #$02
3485 : b1 1b __ LDA (ACCU + 0),y 
3487 : c5 05 __ CMP WORK + 2 
3489 : c8 __ __ INY
348a : b1 1b __ LDA (ACCU + 0),y 
348c : e5 06 __ SBC WORK + 3 
348e : b0 0e __ BCS $349e ; (crt_malloc + 117)
3490 : a5 1b __ LDA ACCU + 0 
3492 : a6 1c __ LDX ACCU + 1 
3494 : 4c 67 34 JMP $3467 ; (crt_malloc + 62)
3497 : a9 00 __ LDA #$00
3499 : 85 1b __ STA ACCU + 0 
349b : 85 1c __ STA ACCU + 1 
349d : 60 __ __ RTS
349e : a5 05 __ LDA WORK + 2 
34a0 : 85 07 __ STA WORK + 4 
34a2 : a5 06 __ LDA WORK + 3 
34a4 : 85 08 __ STA WORK + 5 
34a6 : a0 02 __ LDY #$02
34a8 : a5 07 __ LDA WORK + 4 
34aa : d1 1b __ CMP (ACCU + 0),y 
34ac : d0 15 __ BNE $34c3 ; (crt_malloc + 154)
34ae : c8 __ __ INY
34af : a5 08 __ LDA WORK + 5 
34b1 : d1 1b __ CMP (ACCU + 0),y 
34b3 : d0 0e __ BNE $34c3 ; (crt_malloc + 154)
34b5 : a0 00 __ LDY #$00
34b7 : b1 1b __ LDA (ACCU + 0),y 
34b9 : 91 1d __ STA (ACCU + 2),y 
34bb : c8 __ __ INY
34bc : b1 1b __ LDA (ACCU + 0),y 
34be : 91 1d __ STA (ACCU + 2),y 
34c0 : 4c e0 34 JMP $34e0 ; (crt_malloc + 183)
34c3 : a0 00 __ LDY #$00
34c5 : b1 1b __ LDA (ACCU + 0),y 
34c7 : 91 07 __ STA (WORK + 4),y 
34c9 : a5 07 __ LDA WORK + 4 
34cb : 91 1d __ STA (ACCU + 2),y 
34cd : c8 __ __ INY
34ce : b1 1b __ LDA (ACCU + 0),y 
34d0 : 91 07 __ STA (WORK + 4),y 
34d2 : a5 08 __ LDA WORK + 5 
34d4 : 91 1d __ STA (ACCU + 2),y 
34d6 : c8 __ __ INY
34d7 : b1 1b __ LDA (ACCU + 0),y 
34d9 : 91 07 __ STA (WORK + 4),y 
34db : c8 __ __ INY
34dc : b1 1b __ LDA (ACCU + 0),y 
34de : 91 07 __ STA (WORK + 4),y 
34e0 : a0 00 __ LDY #$00
34e2 : a5 05 __ LDA WORK + 2 
34e4 : 91 1b __ STA (ACCU + 0),y 
34e6 : c8 __ __ INY
34e7 : a5 06 __ LDA WORK + 3 
34e9 : 91 1b __ STA (ACCU + 0),y 
34eb : 18 __ __ CLC
34ec : a5 1b __ LDA ACCU + 0 
34ee : 69 02 __ ADC #$02
34f0 : 85 1b __ STA ACCU + 0 
34f2 : 90 02 __ BCC $34f6 ; (crt_malloc + 205)
34f4 : e6 1c __ INC ACCU + 1 
34f6 : 60 __ __ RTS
--------------------------------------------------------------------
crt_free@proxy: ; crt_free@proxy
34f7 : a5 0d __ LDA P0 
34f9 : 85 1b __ STA ACCU + 0 
34fb : a5 0e __ LDA P1 
34fd : 85 1c __ STA ACCU + 1 
--------------------------------------------------------------------
crt_free: ; crt_free
34ff : a5 1b __ LDA ACCU + 0 
3501 : 05 1c __ ORA ACCU + 1 
3503 : d0 01 __ BNE $3506 ; (crt_free + 7)
3505 : 60 __ __ RTS
3506 : 38 __ __ SEC
3507 : a5 1b __ LDA ACCU + 0 
3509 : e9 02 __ SBC #$02
350b : 85 1b __ STA ACCU + 0 
350d : b0 02 __ BCS $3511 ; (crt_free + 18)
350f : c6 1c __ DEC ACCU + 1 
3511 : a0 00 __ LDY #$00
3513 : b1 1b __ LDA (ACCU + 0),y 
3515 : 85 1d __ STA ACCU + 2 
3517 : c8 __ __ INY
3518 : b1 1b __ LDA (ACCU + 0),y 
351a : 85 1e __ STA ACCU + 3 
351c : a9 ec __ LDA #$ec
351e : a2 3e __ LDX #$3e
3520 : 85 05 __ STA WORK + 2 
3522 : 86 06 __ STX WORK + 3 
3524 : a0 01 __ LDY #$01
3526 : b1 05 __ LDA (WORK + 2),y 
3528 : f0 28 __ BEQ $3552 ; (crt_free + 83)
352a : aa __ __ TAX
352b : 88 __ __ DEY
352c : b1 05 __ LDA (WORK + 2),y 
352e : e4 1e __ CPX ACCU + 3 
3530 : 90 ee __ BCC $3520 ; (crt_free + 33)
3532 : d0 1e __ BNE $3552 ; (crt_free + 83)
3534 : c5 1d __ CMP ACCU + 2 
3536 : 90 e8 __ BCC $3520 ; (crt_free + 33)
3538 : d0 18 __ BNE $3552 ; (crt_free + 83)
353a : a0 00 __ LDY #$00
353c : b1 1d __ LDA (ACCU + 2),y 
353e : 91 1b __ STA (ACCU + 0),y 
3540 : c8 __ __ INY
3541 : b1 1d __ LDA (ACCU + 2),y 
3543 : 91 1b __ STA (ACCU + 0),y 
3545 : c8 __ __ INY
3546 : b1 1d __ LDA (ACCU + 2),y 
3548 : 91 1b __ STA (ACCU + 0),y 
354a : c8 __ __ INY
354b : b1 1d __ LDA (ACCU + 2),y 
354d : 91 1b __ STA (ACCU + 0),y 
354f : 4c 67 35 JMP $3567 ; (crt_free + 104)
3552 : a0 00 __ LDY #$00
3554 : b1 05 __ LDA (WORK + 2),y 
3556 : 91 1b __ STA (ACCU + 0),y 
3558 : c8 __ __ INY
3559 : b1 05 __ LDA (WORK + 2),y 
355b : 91 1b __ STA (ACCU + 0),y 
355d : c8 __ __ INY
355e : a5 1d __ LDA ACCU + 2 
3560 : 91 1b __ STA (ACCU + 0),y 
3562 : c8 __ __ INY
3563 : a5 1e __ LDA ACCU + 3 
3565 : 91 1b __ STA (ACCU + 0),y 
3567 : a0 02 __ LDY #$02
3569 : b1 05 __ LDA (WORK + 2),y 
356b : c5 1b __ CMP ACCU + 0 
356d : d0 1d __ BNE $358c ; (crt_free + 141)
356f : c8 __ __ INY
3570 : b1 05 __ LDA (WORK + 2),y 
3572 : c5 1c __ CMP ACCU + 1 
3574 : d0 16 __ BNE $358c ; (crt_free + 141)
3576 : a0 00 __ LDY #$00
3578 : b1 1b __ LDA (ACCU + 0),y 
357a : 91 05 __ STA (WORK + 2),y 
357c : c8 __ __ INY
357d : b1 1b __ LDA (ACCU + 0),y 
357f : 91 05 __ STA (WORK + 2),y 
3581 : c8 __ __ INY
3582 : b1 1b __ LDA (ACCU + 0),y 
3584 : 91 05 __ STA (WORK + 2),y 
3586 : c8 __ __ INY
3587 : b1 1b __ LDA (ACCU + 0),y 
3589 : 91 05 __ STA (WORK + 2),y 
358b : 60 __ __ RTS
358c : a0 00 __ LDY #$00
358e : a5 1b __ LDA ACCU + 0 
3590 : 91 05 __ STA (WORK + 2),y 
3592 : c8 __ __ INY
3593 : a5 1c __ LDA ACCU + 1 
3595 : 91 05 __ STA (WORK + 2),y 
3597 : 60 __ __ RTS
--------------------------------------------------------------------
strchr@proxy: ; strchr@proxy
3598 : a9 27 __ LDA #$27
359a : 85 0d __ STA P0 
359c : a9 3e __ LDA #$3e
359e : 85 0e __ STA P1 
35a0 : a9 20 __ LDA #$20
35a2 : 85 0f __ STA P2 
35a4 : a9 00 __ LDA #$00
35a6 : 85 10 __ STA P3 
35a8 : 4c 9f 27 JMP $279f ; (strchr.l4 + 0)
--------------------------------------------------------------------
atoi@proxy: ; atoi@proxy
35ab : a9 24 __ LDA #$24
35ad : 85 0d __ STA P0 
35af : a9 3e __ LDA #$3e
35b1 : 85 0e __ STA P1 
35b3 : 4c e5 26 JMP $26e5 ; (atoi.l4 + 0)
--------------------------------------------------------------------
uci_socket_write@proxy: ; uci_socket_write@proxy
35b6 : ad ef 36 LDA $36ef ; (socket_id + 0)
35b9 : 85 11 __ STA P4 
35bb : 4c 3b 26 JMP $263b ; (uci_socket_write.s4 + 0)
--------------------------------------------------------------------
freg@proxy: ; freg@proxy
35be : a9 20 __ LDA #$20
35c0 : 85 05 __ STA WORK + 2 
35c2 : a9 41 __ LDA #$41
35c4 : 85 06 __ STA WORK + 3 
35c6 : 4c fa 2e JMP $2efa ; (freg + 20)
--------------------------------------------------------------------
freg@proxy: ; freg@proxy
35c9 : a5 43 __ LDA $43 
35cb : 85 1b __ STA ACCU + 0 
35cd : a5 44 __ LDA $44 
35cf : 85 1c __ STA ACCU + 1 
35d1 : a5 45 __ LDA $45 
35d3 : 85 1d __ STA ACCU + 2 
35d5 : a5 46 __ LDA $46 
35d7 : 85 1e __ STA ACCU + 3 
35d9 : 4c ea 2e JMP $2eea ; (freg + 4)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
35dc : a9 00 __ LDA #$00
35de : 85 0d __ STA P0 
35e0 : 4c a1 0f JMP $0fa1 ; (print_at.s4 + 0)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
35e3 : a9 00 __ LDA #$00
35e5 : 85 0d __ STA P0 
35e7 : a9 04 __ LDA #$04
35e9 : 85 0e __ STA P1 
35eb : 4c a1 0f JMP $0fa1 ; (print_at.s4 + 0)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
35ee : a9 00 __ LDA #$00
35f0 : 85 0d __ STA P0 
35f2 : a9 18 __ LDA #$18
35f4 : 85 0e __ STA P1 
35f6 : a9 ef __ LDA #$ef
35f8 : 85 0f __ STA P2 
35fa : a9 21 __ LDA #$21
35fc : 85 10 __ STA P3 
35fe : 4c a1 0f JMP $0fa1 ; (print_at.s4 + 0)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
3601 : a9 08 __ LDA #$08
3603 : 85 0d __ STA P0 
3605 : 4c a1 0f JMP $0fa1 ; (print_at.s4 + 0)
--------------------------------------------------------------------
print_at_color@proxy: ; print_at_color@proxy
3608 : a9 02 __ LDA #$02
360a : 85 0d __ STA P0 
360c : 4c 15 15 JMP $1515 ; (print_at_color.s4 + 0)
--------------------------------------------------------------------
print_at_color@proxy: ; print_at_color@proxy
360f : a9 00 __ LDA #$00
3611 : 85 0d __ STA P0 
3613 : a9 a2 __ LDA #$a2
3615 : 85 0f __ STA P2 
3617 : a9 15 __ LDA #$15
3619 : 85 10 __ STA P3 
361b : a9 01 __ LDA #$01
361d : 85 11 __ STA P4 
361f : 4c 15 15 JMP $1515 ; (print_at_color.s4 + 0)
--------------------------------------------------------------------
print_at_color@proxy: ; print_at_color@proxy
3622 : a9 a2 __ LDA #$a2
3624 : 85 0f __ STA P2 
3626 : a9 15 __ LDA #$15
3628 : 85 10 __ STA P3 
362a : a9 01 __ LDA #$01
362c : 85 11 __ STA P4 
362e : 4c 15 15 JMP $1515 ; (print_at_color.s4 + 0)
--------------------------------------------------------------------
print_at_color@proxy: ; print_at_color@proxy
3631 : a9 02 __ LDA #$02
3633 : 85 0d __ STA P0 
3635 : a9 a4 __ LDA #$a4
3637 : 85 0f __ STA P2 
3639 : a9 15 __ LDA #$15
363b : 85 10 __ STA P3 
363d : 4c 15 15 JMP $1515 ; (print_at_color.s4 + 0)
--------------------------------------------------------------------
spentry:
3640 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
uci_target:
3641 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
server_host:
3642 : __ __ __ BYT 31 39 32 2e 31 36 38 2e 32 2e 36 36 00 00 00 00 : 192.168.2.66....
3652 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
--------------------------------------------------------------------
current_page:
3662 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
settings_cursor:
3664 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
settings_editing:
3666 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
settings_edit_pos:
3667 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
keyb_codes:
3669 : __ __ __ BYT 14 0d 1d 88 85 86 87 11 33 77 61 34 7a 73 65 00 : ........3wa4zse.
3679 : __ __ __ BYT 35 72 64 36 63 66 74 78 37 79 67 38 62 68 75 76 : 5rd6cftx7yg8bhuv
3689 : __ __ __ BYT 39 69 6a 30 6d 6b 6f 6e 2b 70 6c 2d 2e 3a 40 2c : 9ij0mkon+pl-.:@,
3699 : __ __ __ BYT 00 2a 3b 13 00 3d 5e 2f 31 5f 00 32 20 00 71 1b : .*;..=^/1_.2 .q.
36a9 : __ __ __ BYT 94 0d 9d 8c 89 8a 8b 91 23 57 41 24 5a 53 45 00 : ........#WA$ZSE.
36b9 : __ __ __ BYT 25 52 44 26 43 46 54 58 27 59 47 28 42 48 55 56 : %RD&CFTX'YG(BHUV
36c9 : __ __ __ BYT 29 49 4a 30 4d 4b 4f 4e 00 50 4c 00 3e 5b 40 3c : )IJ0MKON.PL.>[@<
36d9 : __ __ __ BYT 00 00 5d 93 00 00 5e 3f 21 00 00 22 20 00 51 1b : ..]...^?!.." .Q.
--------------------------------------------------------------------
item_count:
36e9 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
uci_data_index:
36eb : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
uci_data_len:
36ed : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
socket_id:
36ef : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
connected:
36f0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
total_count:
36f1 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
cursor:
36f3 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
offset:
36f5 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
search_query_len:
36f7 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
keyb_key:
36f9 : __ __ __ BSS	1
--------------------------------------------------------------------
ciaa_pra_def:
36fa : __ __ __ BSS	1
--------------------------------------------------------------------
temp_char:
36fb : __ __ __ BSS	2
--------------------------------------------------------------------
fround5:
3700 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
3710 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
uci_data:
371c : __ __ __ BSS	1792
--------------------------------------------------------------------
keyb_matrix:
3e1c : __ __ __ BSS	8
--------------------------------------------------------------------
line_buffer:
3e24 : __ __ __ BSS	128
--------------------------------------------------------------------
item_ids:
3ea4 : __ __ __ BSS	40
--------------------------------------------------------------------
search_query:
3ecc : __ __ __ BSS	32
--------------------------------------------------------------------
HeapNode:
3eec : __ __ __ BSS	4
--------------------------------------------------------------------
uci_status:
3f00 : __ __ __ BSS	256
--------------------------------------------------------------------
item_names:
4000 : __ __ __ BSS	640
--------------------------------------------------------------------
current_category:
4280 : __ __ __ BSS	32
