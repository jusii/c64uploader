; Compiled with 1.32.266
--------------------------------------------------------------------
uci_data:
0900 : __ __ __ BSS	1792
--------------------------------------------------------------------
uci_status:
1000 : __ __ __ BSS	256
--------------------------------------------------------------------
keyb_key:
1100 : __ __ __ BSS	1
--------------------------------------------------------------------
keyb_matrix:
1101 : __ __ __ BSS	8
--------------------------------------------------------------------
ciaa_pra_def:
1109 : __ __ __ BSS	1
--------------------------------------------------------------------
line_buffer:
110a : __ __ __ BSS	128
--------------------------------------------------------------------
temp_char:
118a : __ __ __ BSS	2
--------------------------------------------------------------------
item_names:
118c : __ __ __ BSS	640
--------------------------------------------------------------------
item_ids:
140c : __ __ __ BSS	40
--------------------------------------------------------------------
search_query:
1434 : __ __ __ BSS	32
--------------------------------------------------------------------
current_category:
1454 : __ __ __ BSS	32
--------------------------------------------------------------------
HeapNode:
1474 : __ __ __ BSS	4
--------------------------------------------------------------------
startup: ; startup
00:8000 : 09 80 __ ORA #$80
00:8002 : 09 80 __ ORA #$80
00:8004 : c3 __ __ INV
00:8005 : c2 __ __ INV
00:8006 : cd 38 30 CMP $3038 
00:8009 : a9 e7 __ LDA #$e7
00:800b : 85 01 __ STA $01 
00:800d : a9 2f __ LDA #$2f
00:800f : 85 00 __ STA $00 
00:8011 : a2 09 __ LDX #$09
00:8013 : a0 00 __ LDY #$00
00:8015 : a9 00 __ LDA #$00
00:8017 : 85 19 __ STA IP + 0 
00:8019 : 86 1a __ STX IP + 1 
00:801b : e0 14 __ CPX #$14
00:801d : f0 0b __ BEQ $802a ; (startup + 42)
00:801f : 91 19 __ STA (IP + 0),y 
00:8021 : c8 __ __ INY
00:8022 : d0 fb __ BNE $801f ; (startup + 31)
00:8024 : e8 __ __ INX
00:8025 : d0 f2 __ BNE $8019 ; (startup + 25)
00:8027 : 91 19 __ STA (IP + 0),y 
00:8029 : c8 __ __ INY
00:802a : c0 78 __ CPY #$78
00:802c : d0 f9 __ BNE $8027 ; (startup + 39)
00:802e : a9 00 __ LDA #$00
00:8030 : a2 f7 __ LDX #$f7
00:8032 : d0 03 __ BNE $8037 ; (startup + 55)
00:8034 : 95 00 __ STA $00,x 
00:8036 : e8 __ __ INX
00:8037 : e0 f7 __ CPX #$f7
00:8039 : d0 f9 __ BNE $8034 ; (startup + 52)
00:803b : a9 7c __ LDA #$7c
00:803d : 85 23 __ STA SP + 0 
00:803f : a9 46 __ LDA #$46
00:8041 : 85 24 __ STA SP + 1 
00:8043 : 20 80 80 JSR $8080 ; (main.s1 + 0)
00:8046 : a9 4c __ LDA #$4c
00:8048 : 85 54 __ STA $54 
00:804a : a9 00 __ LDA #$00
00:804c : 85 13 __ STA P6 
00:804e : a9 19 __ LDA #$19
00:8050 : 85 16 __ STA P9 
00:8052 : 60 __ __ RTS
--------------------------------------------------------------------
main: ; main()->i16
; 514, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
00:8080 : a2 05 __ LDX #$05
00:8082 : b5 53 __ LDA T0 + 0,x 
00:8084 : 9d 7e 46 STA $467e,x ; (main@stack + 0)
00:8087 : ca __ __ DEX
00:8088 : 10 f8 __ BPL $8082 ; (main.s1 + 2)
.s4:
00:808a : a9 00 __ LDA #$00
00:808c : 85 0d __ STA P0 
00:808e : 85 0e __ STA P1 
00:8090 : 8d 20 d0 STA $d020 
00:8093 : 8d 21 d0 STA $d021 
00:8096 : 20 66 84 JSR $8466 ; (clear_screen.s4 + 0)
00:8099 : a9 50 __ LDA #$50
00:809b : 85 0f __ STA P2 
00:809d : a9 85 __ LDA #$85
00:809f : 85 10 __ STA P3 
00:80a1 : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:80a4 : a9 02 __ LDA #$02
00:80a6 : 85 0e __ STA P1 
00:80a8 : a9 85 __ LDA #$85
00:80aa : 85 10 __ STA P3 
00:80ac : a9 63 __ LDA #$63
00:80ae : 85 0f __ STA P2 
00:80b0 : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:80b3 : a9 01 __ LDA #$01
00:80b5 : 8d ff 99 STA $99ff ; (uci_target + 0)
00:80b8 : 8d 85 46 STA $4685 ; (cmd[0] + 1)
00:80bb : a9 02 __ LDA #$02
00:80bd : 85 0f __ STA P2 
00:80bf : a9 00 __ LDA #$00
00:80c1 : 85 10 __ STA P3 
00:80c3 : 8d 84 46 STA $4684 ; (cmd[0] + 0)
00:80c6 : a9 84 __ LDA #$84
00:80c8 : 85 0d __ STA P0 
00:80ca : a9 46 __ LDA #$46
00:80cc : 85 0e __ STA P1 
00:80ce : 20 78 85 JSR $8578 ; (uci_sendcommand.s4 + 0)
00:80d1 : 20 dd 85 JSR $85dd ; (uci_readdata.s4 + 0)
00:80d4 : 20 06 86 JSR $8606 ; (uci_readstatus.s4 + 0)
00:80d7 : 20 2f 86 JSR $862f ; (uci_accept.s4 + 0)
00:80da : ad 00 10 LDA $1000 ; (uci_status[0] + 0)
00:80dd : c9 30 __ CMP #$30
00:80df : d0 07 __ BNE $80e8 ; (main.s5 + 0)
.s6:
00:80e1 : ad 01 10 LDA $1001 ; (uci_status[0] + 1)
00:80e4 : c9 30 __ CMP #$30
00:80e6 : f0 0f __ BEQ $80f7 ; (main.s7 + 0)
.s5:
00:80e8 : a9 86 __ LDA #$86
00:80ea : 85 10 __ STA P3 
00:80ec : a9 3f __ LDA #$3f
00:80ee : 85 0f __ STA P2 
00:80f0 : 20 42 a7 JSR $a742 ; (print_at@proxy + 0)
00:80f3 : a9 06 __ LDA #$06
00:80f5 : d0 66 __ BNE $815d ; (main.s91 + 0)
.s7:
00:80f7 : a9 87 __ LDA #$87
00:80f9 : 85 10 __ STA P3 
00:80fb : a9 2f __ LDA #$2f
00:80fd : 85 0f __ STA P2 
00:80ff : 20 42 a7 JSR $a742 ; (print_at@proxy + 0)
00:8102 : a9 06 __ LDA #$06
00:8104 : 85 0e __ STA P1 
00:8106 : a9 87 __ LDA #$87
00:8108 : 85 10 __ STA P3 
00:810a : a9 45 __ LDA #$45
00:810c : 85 0f __ STA P2 
00:810e : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:8111 : 20 5b 87 JSR $875b ; (uci_getipaddress.s4 + 0)
00:8114 : ad 00 10 LDA $1000 ; (uci_status[0] + 0)
00:8117 : c9 30 __ CMP #$30
00:8119 : d0 25 __ BNE $8140 ; (main.s8 + 0)
.s87:
00:811b : ad 01 10 LDA $1001 ; (uci_status[0] + 1)
00:811e : c9 30 __ CMP #$30
00:8120 : d0 1e __ BNE $8140 ; (main.s8 + 0)
.s88:
00:8122 : a9 87 __ LDA #$87
00:8124 : 85 10 __ STA P3 
00:8126 : a9 08 __ LDA #$08
00:8128 : 85 0e __ STA P1 
00:812a : a9 90 __ LDA #$90
00:812c : 85 0f __ STA P2 
00:812e : 20 4d a7 JSR $a74d ; (print_at@proxy + 0)
00:8131 : a9 04 __ LDA #$04
00:8133 : 85 0d __ STA P0 
00:8135 : a9 09 __ LDA #$09
00:8137 : 85 10 __ STA P3 
00:8139 : a9 00 __ LDA #$00
00:813b : 85 0f __ STA P2 
00:813d : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
.s8:
00:8140 : a9 87 __ LDA #$87
00:8142 : 85 10 __ STA P3 
00:8144 : a9 0a __ LDA #$0a
00:8146 : 85 0e __ STA P1 
00:8148 : a9 95 __ LDA #$95
00:814a : 85 0f __ STA P2 
00:814c : 20 4d a7 JSR $a74d ; (print_at@proxy + 0)
00:814f : 20 6d 86 JSR $866d ; (wait_key.l5 + 0)
00:8152 : 20 ae 87 JSR $87ae ; (connect_to_server.s4 + 0)
00:8155 : a5 1b __ LDA ACCU + 0 
00:8157 : d0 27 __ BNE $8180 ; (main.l90 + 0)
.s9:
00:8159 : 85 0d __ STA P0 
00:815b : a9 0c __ LDA #$0c
.s91:
00:815d : 85 0e __ STA P1 
00:815f : a9 57 __ LDA #$57
00:8161 : 85 0f __ STA P2 
00:8163 : a9 86 __ LDA #$86
00:8165 : 85 10 __ STA P3 
00:8167 : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:816a : 20 6d 86 JSR $866d ; (wait_key.l5 + 0)
00:816d : a9 01 __ LDA #$01
00:816f : 85 1b __ STA ACCU + 0 
00:8171 : a9 00 __ LDA #$00
.s3:
00:8173 : 85 1c __ STA ACCU + 1 
00:8175 : a2 05 __ LDX #$05
00:8177 : bd 7e 46 LDA $467e,x ; (main@stack + 0)
00:817a : 95 53 __ STA T0 + 0,x 
00:817c : ca __ __ DEX
00:817d : 10 f8 __ BPL $8177 ; (main.s3 + 4)
00:817f : 60 __ __ RTS
.l90:
00:8180 : 20 0b 8a JSR $8a0b ; (load_categories.s4 + 0)
00:8183 : a9 9a __ LDA #$9a
00:8185 : a2 47 __ LDX #$47
.l89:
00:8187 : 86 53 __ STX T0 + 0 
00:8189 : 85 54 __ STA T0 + 1 
.l10:
00:818b : a5 53 __ LDA T0 + 0 
00:818d : 8d fe 46 STA $46fe ; (sstack + 8)
00:8190 : a5 54 __ LDA T0 + 1 
.l11:
00:8192 : 8d ff 46 STA $46ff ; (sstack + 9)
00:8195 : 20 fd 8c JSR $8cfd ; (draw_list.s1 + 0)
.l12:
00:8198 : 20 5f 9a JSR $9a5f ; (get_key.s1 + 0)
00:819b : a5 1b __ LDA ACCU + 0 
00:819d : f0 f9 __ BEQ $8198 ; (main.l12 + 0)
.s13:
00:819f : ad 63 a7 LDA $a763 ; (current_page + 1)
00:81a2 : 85 56 __ STA T1 + 1 
00:81a4 : d0 0a __ BNE $81b0 ; (main.s14 + 0)
.s16:
00:81a6 : ac 62 a7 LDY $a762 ; (current_page + 0)
00:81a9 : c0 01 __ CPY #$01
00:81ab : d0 03 __ BNE $81b0 ; (main.s14 + 0)
00:81ad : 4c 55 84 JMP $8455 ; (main.s15 + 0)
.s14:
00:81b0 : a0 00 __ LDY #$00
00:81b2 : aa __ __ TAX
00:81b3 : d0 0a __ BNE $81bf ; (main.s17 + 0)
.s85:
00:81b5 : ad 62 a7 LDA $a762 ; (current_page + 0)
00:81b8 : c9 02 __ CMP #$02
00:81ba : d0 03 __ BNE $81bf ; (main.s17 + 0)
00:81bc : 4c 48 84 JMP $8448 ; (main.s83 + 0)
.s17:
00:81bf : a5 1b __ LDA ACCU + 0 
00:81c1 : c9 64 __ CMP #$64
00:81c3 : d0 03 __ BNE $81c8 ; (main.s18 + 0)
00:81c5 : 4c 0d 84 JMP $840d ; (main.s77 + 0)
.s18:
00:81c8 : a9 9a __ LDA #$9a
00:81ca : a2 47 __ LDX #$47
.s19:
00:81cc : 85 58 __ STA T3 + 1 
00:81ce : a5 1b __ LDA ACCU + 0 
00:81d0 : c9 64 __ CMP #$64
00:81d2 : b0 03 __ BCS $81d7 ; (main.s20 + 0)
00:81d4 : 4c 01 83 JMP $8301 ; (main.s55 + 0)
.s20:
00:81d7 : c9 71 __ CMP #$71
00:81d9 : d0 25 __ BNE $8200 ; (main.s21 + 0)
.s53:
00:81db : ad 62 a7 LDA $a762 ; (current_page + 0)
00:81de : 05 56 __ ORA T1 + 1 
00:81e0 : d0 b6 __ BNE $8198 ; (main.l12 + 0)
.s54:
00:81e2 : 20 de 9f JSR $9fde ; (disconnect_from_server.s4 + 0)
00:81e5 : a9 00 __ LDA #$00
00:81e7 : 85 0d __ STA P0 
00:81e9 : 85 0e __ STA P1 
00:81eb : 20 66 84 JSR $8466 ; (clear_screen.s4 + 0)
00:81ee : a9 30 __ LDA #$30
00:81f0 : 85 0f __ STA P2 
00:81f2 : a9 a0 __ LDA #$a0
00:81f4 : 85 10 __ STA P3 
00:81f6 : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:81f9 : a9 00 __ LDA #$00
00:81fb : 85 1b __ STA ACCU + 0 
00:81fd : 4c 73 81 JMP $8173 ; (main.s3 + 0)
.s21:
00:8200 : b0 03 __ BCS $8205 ; (main.s22 + 0)
00:8202 : 4c 8b 82 JMP $828b ; (main.s38 + 0)
.s22:
00:8205 : c9 75 __ CMP #$75
00:8207 : d0 2b __ BNE $8234 ; (main.s23 + 0)
.s34:
00:8209 : ad 5f a7 LDA $a75f ; (cursor + 1)
00:820c : 30 8a __ BMI $8198 ; (main.l12 + 0)
.s37:
00:820e : 0d 5e a7 ORA $a75e ; (cursor + 0)
00:8211 : f0 85 __ BEQ $8198 ; (main.l12 + 0)
.s35:
00:8213 : ad 5e a7 LDA $a75e ; (cursor + 0)
00:8216 : 85 17 __ STA P10 
00:8218 : 69 fe __ ADC #$fe
00:821a : aa __ __ TAX
00:821b : ad 5f a7 LDA $a75f ; (cursor + 1)
00:821e : 85 18 __ STA P11 
00:8220 : 69 ff __ ADC #$ff
.s36:
00:8222 : 8e f6 46 STX $46f6 ; (sstack + 0)
00:8225 : 8e 5e a7 STX $a75e ; (cursor + 0)
00:8228 : 8d f7 46 STA $46f7 ; (sstack + 1)
00:822b : 8d 5f a7 STA $a75f ; (cursor + 1)
00:822e : 20 88 9b JSR $9b88 ; (update_cursor.s4 + 0)
00:8231 : 4c 98 81 JMP $8198 ; (main.l12 + 0)
.s23:
00:8234 : a5 56 __ LDA T1 + 1 
00:8236 : d0 f9 __ BNE $8231 ; (main.s36 + 15)
.s33:
00:8238 : ad 62 a7 LDA $a762 ; (current_page + 0)
00:823b : c9 02 __ CMP #$02
00:823d : d0 f2 __ BNE $8231 ; (main.s36 + 15)
.s24:
00:823f : a5 1b __ LDA ACCU + 0 
00:8241 : c9 41 __ CMP #$41
00:8243 : 90 04 __ BCC $8249 ; (main.s25 + 0)
.s32:
00:8245 : c9 5b __ CMP #$5b
00:8247 : 90 08 __ BCC $8251 ; (main.s27 + 0)
.s25:
00:8249 : c9 30 __ CMP #$30
00:824b : 90 e4 __ BCC $8231 ; (main.s36 + 15)
.s26:
00:824d : c9 3a __ CMP #$3a
00:824f : b0 e0 __ BCS $8231 ; (main.s36 + 15)
.s27:
00:8251 : ae 64 a7 LDX $a764 ; (search_query_len + 0)
00:8254 : ad 65 a7 LDA $a765 ; (search_query_len + 1)
00:8257 : 30 06 __ BMI $825f ; (main.s28 + 0)
.s31:
00:8259 : d0 d6 __ BNE $8231 ; (main.s36 + 15)
.s30:
00:825b : e0 1e __ CPX #$1e
00:825d : b0 d2 __ BCS $8231 ; (main.s36 + 15)
.s28:
00:825f : 8a __ __ TXA
00:8260 : 18 __ __ CLC
00:8261 : 69 01 __ ADC #$01
00:8263 : 8d 64 a7 STA $a764 ; (search_query_len + 0)
00:8266 : a5 1b __ LDA ACCU + 0 
00:8268 : 9d 34 14 STA $1434,x ; (search_query[0] + 0)
00:826b : a9 00 __ LDA #$00
00:826d : 8d 65 a7 STA $a765 ; (search_query_len + 1)
00:8270 : 9d 35 14 STA $1435,x ; (search_query[0] + 1)
00:8273 : ad 64 a7 LDA $a764 ; (search_query_len + 0)
00:8276 : c9 02 __ CMP #$02
00:8278 : a9 74 __ LDA #$74
00:827a : 85 53 __ STA T0 + 0 
00:827c : a9 9b __ LDA #$9b
00:827e : 85 54 __ STA T0 + 1 
00:8280 : b0 03 __ BCS $8285 ; (main.s29 + 0)
00:8282 : 4c 8b 81 JMP $818b ; (main.l10 + 0)
.s29:
00:8285 : 20 4c 9e JSR $9e4c ; (do_search.s1 + 0)
00:8288 : 4c 8b 81 JMP $818b ; (main.l10 + 0)
.s38:
00:828b : 86 57 __ STX T3 + 0 
00:828d : c9 6e __ CMP #$6e
00:828f : d0 4a __ BNE $82db ; (main.s39 + 0)
.s46:
00:8291 : 98 __ __ TYA
00:8292 : f0 9d __ BEQ $8231 ; (main.s36 + 15)
.s47:
00:8294 : ad 5a a7 LDA $a75a ; (item_count + 0)
00:8297 : 18 __ __ CLC
00:8298 : 6d 60 a7 ADC $a760 ; (offset + 0)
00:829b : aa __ __ TAX
00:829c : ad 5b a7 LDA $a75b ; (item_count + 1)
00:829f : 6d 61 a7 ADC $a761 ; (offset + 1)
00:82a2 : cd 5d a7 CMP $a75d ; (total_count + 1)
00:82a5 : d0 06 __ BNE $82ad ; (main.s52 + 0)
.s49:
00:82a7 : ec 5c a7 CPX $a75c ; (total_count + 0)
00:82aa : 4c b2 82 JMP $82b2 ; (main.s50 + 0)
.s52:
00:82ad : 4d 5d a7 EOR $a75d ; (total_count + 1)
00:82b0 : 30 24 __ BMI $82d6 ; (main.s51 + 0)
.s50:
00:82b2 : 90 03 __ BCC $82b7 ; (main.s48 + 0)
00:82b4 : 4c 98 81 JMP $8198 ; (main.l12 + 0)
.s48:
00:82b7 : ad 60 a7 LDA $a760 ; (offset + 0)
00:82ba : 18 __ __ CLC
00:82bb : 69 14 __ ADC #$14
00:82bd : aa __ __ TAX
00:82be : ad 61 a7 LDA $a761 ; (offset + 1)
00:82c1 : 69 00 __ ADC #$00
.s43:
00:82c3 : 8e fe 46 STX $46fe ; (sstack + 8)
00:82c6 : 8d ff 46 STA $46ff ; (sstack + 9)
00:82c9 : 20 de 9b JSR $9bde ; (load_entries.s1 + 0)
00:82cc : a5 57 __ LDA T3 + 0 
00:82ce : 8d fe 46 STA $46fe ; (sstack + 8)
00:82d1 : a5 58 __ LDA T3 + 1 
00:82d3 : 4c 92 81 JMP $8192 ; (main.l11 + 0)
.s51:
00:82d6 : b0 df __ BCS $82b7 ; (main.s48 + 0)
00:82d8 : 4c 98 81 JMP $8198 ; (main.l12 + 0)
.s39:
00:82db : c9 70 __ CMP #$70
00:82dd : f0 03 __ BEQ $82e2 ; (main.s40 + 0)
00:82df : 4c 34 82 JMP $8234 ; (main.s23 + 0)
.s40:
00:82e2 : 98 __ __ TYA
00:82e3 : f0 f3 __ BEQ $82d8 ; (main.s51 + 2)
.s41:
00:82e5 : ad 61 a7 LDA $a761 ; (offset + 1)
00:82e8 : 30 ee __ BMI $82d8 ; (main.s51 + 2)
.s45:
00:82ea : 0d 60 a7 ORA $a760 ; (offset + 0)
00:82ed : f0 e9 __ BEQ $82d8 ; (main.s51 + 2)
.s42:
00:82ef : ad 60 a7 LDA $a760 ; (offset + 0)
00:82f2 : e9 14 __ SBC #$14
00:82f4 : aa __ __ TAX
00:82f5 : ad 61 a7 LDA $a761 ; (offset + 1)
00:82f8 : e9 00 __ SBC #$00
00:82fa : 10 c7 __ BPL $82c3 ; (main.s43 + 0)
.s44:
00:82fc : a9 00 __ LDA #$00
00:82fe : aa __ __ TAX
00:82ff : f0 c2 __ BEQ $82c3 ; (main.s43 + 0)
.s55:
00:8301 : c9 2f __ CMP #$2f
00:8303 : d0 37 __ BNE $833c ; (main.s56 + 0)
.s75:
00:8305 : ad 62 a7 LDA $a762 ; (current_page + 0)
00:8308 : 05 56 __ ORA T1 + 1 
00:830a : d0 cc __ BNE $82d8 ; (main.s51 + 2)
.s76:
00:830c : 8d 60 a7 STA $a760 ; (offset + 0)
00:830f : 8d 61 a7 STA $a761 ; (offset + 1)
00:8312 : 8d 5e a7 STA $a75e ; (cursor + 0)
00:8315 : 8d 5f a7 STA $a75f ; (cursor + 1)
00:8318 : 8d 5c a7 STA $a75c ; (total_count + 0)
00:831b : 8d 5d a7 STA $a75d ; (total_count + 1)
00:831e : 8d 5a a7 STA $a75a ; (item_count + 0)
00:8321 : 8d 5b a7 STA $a75b ; (item_count + 1)
00:8324 : 8d 64 a7 STA $a764 ; (search_query_len + 0)
00:8327 : 8d 65 a7 STA $a765 ; (search_query_len + 1)
00:832a : 8d 34 14 STA $1434 ; (search_query[0] + 0)
00:832d : 8d 63 a7 STA $a763 ; (current_page + 1)
00:8330 : a9 02 __ LDA #$02
00:8332 : 8d 62 a7 STA $a762 ; (current_page + 0)
00:8335 : a9 9b __ LDA #$9b
00:8337 : a2 74 __ LDX #$74
00:8339 : 4c 87 81 JMP $8187 ; (main.l89 + 0)
.s56:
00:833c : 90 46 __ BCC $8384 ; (main.s62 + 0)
.s57:
00:833e : c9 3e __ CMP #$3e
00:8340 : d0 9d __ BNE $82df ; (main.s39 + 4)
.s58:
00:8342 : ad 62 a7 LDA $a762 ; (current_page + 0)
00:8345 : 05 56 __ ORA T1 + 1 
00:8347 : d0 8f __ BNE $82d8 ; (main.s51 + 2)
.s59:
00:8349 : 8d fe 46 STA $46fe ; (sstack + 8)
00:834c : 8d ff 46 STA $46ff ; (sstack + 9)
00:834f : ad 5e a7 LDA $a75e ; (cursor + 0)
00:8352 : 85 1c __ STA ACCU + 1 
00:8354 : ad 5f a7 LDA $a75f ; (cursor + 1)
00:8357 : 4a __ __ LSR
00:8358 : 66 1c __ ROR ACCU + 1 
00:835a : 6a __ __ ROR
00:835b : 66 1c __ ROR ACCU + 1 
00:835d : 6a __ __ ROR
00:835e : 66 1c __ ROR ACCU + 1 
00:8360 : 29 c0 __ AND #$c0
00:8362 : 6a __ __ ROR
00:8363 : 69 8c __ ADC #$8c
00:8365 : 85 53 __ STA T0 + 0 
00:8367 : a9 11 __ LDA #$11
00:8369 : 65 1c __ ADC ACCU + 1 
00:836b : 85 54 __ STA T0 + 1 
00:836d : a0 ff __ LDY #$ff
.l60:
00:836f : c8 __ __ INY
00:8370 : b1 53 __ LDA (T0 + 0),y 
00:8372 : 99 54 14 STA $1454,y ; (current_category[0] + 0)
00:8375 : d0 f8 __ BNE $836f ; (main.l60 + 0)
.s61:
00:8377 : 20 de 9b JSR $9bde ; (load_entries.s1 + 0)
00:837a : a9 54 __ LDA #$54
00:837c : 8d fe 46 STA $46fe ; (sstack + 8)
00:837f : a9 14 __ LDA #$14
00:8381 : 4c 92 81 JMP $8192 ; (main.l11 + 0)
.s62:
00:8384 : c9 08 __ CMP #$08
00:8386 : f0 32 __ BEQ $83ba ; (main.s68 + 0)
.s63:
00:8388 : c9 0d __ CMP #$0d
00:838a : f0 03 __ BEQ $838f ; (main.s64 + 0)
00:838c : 4c 34 82 JMP $8234 ; (main.s23 + 0)
.s64:
00:838f : ad 62 a7 LDA $a762 ; (current_page + 0)
00:8392 : 05 56 __ ORA T1 + 1 
00:8394 : f0 b3 __ BEQ $8349 ; (main.s59 + 0)
.s65:
00:8396 : ad 5b a7 LDA $a75b ; (item_count + 1)
00:8399 : 10 03 __ BPL $839e ; (main.s67 + 0)
00:839b : 4c 98 81 JMP $8198 ; (main.l12 + 0)
.s67:
00:839e : 0d 5a a7 ORA $a75a ; (item_count + 0)
00:83a1 : f0 f8 __ BEQ $839b ; (main.s65 + 5)
.s66:
00:83a3 : ad 5e a7 LDA $a75e ; (cursor + 0)
00:83a6 : 0a __ __ ASL
00:83a7 : aa __ __ TAX
00:83a8 : bd 0c 14 LDA $140c,x ; (item_ids[0] + 0)
00:83ab : 8d fe 46 STA $46fe ; (sstack + 8)
00:83ae : bd 0d 14 LDA $140d,x ; (item_ids[0] + 1)
00:83b1 : 8d ff 46 STA $46ff ; (sstack + 9)
00:83b4 : 20 e7 9d JSR $9de7 ; (run_entry.s4 + 0)
00:83b7 : 4c 98 81 JMP $8198 ; (main.l12 + 0)
.s68:
00:83ba : a5 56 __ LDA T1 + 1 
00:83bc : d0 49 __ BNE $8407 ; (main.s69 + 0)
.s74:
00:83be : ad 62 a7 LDA $a762 ; (current_page + 0)
00:83c1 : c9 02 __ CMP #$02
00:83c3 : d0 42 __ BNE $8407 ; (main.s69 + 0)
.s70:
00:83c5 : ad 64 a7 LDA $a764 ; (search_query_len + 0)
00:83c8 : 85 53 __ STA T0 + 0 
00:83ca : ad 65 a7 LDA $a765 ; (search_query_len + 1)
00:83cd : 10 03 __ BPL $83d2 ; (main.s73 + 0)
00:83cf : 4c 80 81 JMP $8180 ; (main.l90 + 0)
.s73:
00:83d2 : 05 53 __ ORA T0 + 0 
00:83d4 : f0 f9 __ BEQ $83cf ; (main.s70 + 10)
.s71:
00:83d6 : a6 53 __ LDX T0 + 0 
00:83d8 : ca __ __ DEX
00:83d9 : 8e 64 a7 STX $a764 ; (search_query_len + 0)
00:83dc : a9 00 __ LDA #$00
00:83de : 8d 65 a7 STA $a765 ; (search_query_len + 1)
00:83e1 : 9d 34 14 STA $1434,x ; (search_query[0] + 0)
00:83e4 : ad 64 a7 LDA $a764 ; (search_query_len + 0)
00:83e7 : c9 02 __ CMP #$02
00:83e9 : a9 74 __ LDA #$74
00:83eb : 85 53 __ STA T0 + 0 
00:83ed : a9 9b __ LDA #$9b
00:83ef : 85 54 __ STA T0 + 1 
00:83f1 : 90 03 __ BCC $83f6 ; (main.s72 + 0)
00:83f3 : 4c 85 82 JMP $8285 ; (main.s29 + 0)
.s72:
00:83f6 : a9 00 __ LDA #$00
00:83f8 : 8d 5c a7 STA $a75c ; (total_count + 0)
00:83fb : 8d 5d a7 STA $a75d ; (total_count + 1)
00:83fe : 8d 5a a7 STA $a75a ; (item_count + 0)
00:8401 : 8d 5b a7 STA $a75b ; (item_count + 1)
00:8404 : 4c 8b 81 JMP $818b ; (main.l10 + 0)
.s69:
00:8407 : 98 __ __ TYA
00:8408 : f0 ad __ BEQ $83b7 ; (main.s66 + 20)
00:840a : 4c 80 81 JMP $8180 ; (main.l90 + 0)
.s77:
00:840d : ad 5a a7 LDA $a75a ; (item_count + 0)
00:8410 : e9 01 __ SBC #$01
00:8412 : 85 53 __ STA T0 + 0 
00:8414 : ad 5b a7 LDA $a75b ; (item_count + 1)
00:8417 : e9 00 __ SBC #$00
00:8419 : 85 54 __ STA T0 + 1 
00:841b : ad 5f a7 LDA $a75f ; (cursor + 1)
00:841e : c5 54 __ CMP T0 + 1 
00:8420 : d0 08 __ BNE $842a ; (main.s82 + 0)
.s79:
00:8422 : ad 5e a7 LDA $a75e ; (cursor + 0)
00:8425 : c5 53 __ CMP T0 + 0 
00:8427 : 4c 2e 84 JMP $842e ; (main.s80 + 0)
.s82:
00:842a : 45 54 __ EOR T0 + 1 
00:842c : 30 15 __ BMI $8443 ; (main.s81 + 0)
.s80:
00:842e : b0 87 __ BCS $83b7 ; (main.s66 + 20)
.s78:
00:8430 : ad 5e a7 LDA $a75e ; (cursor + 0)
00:8433 : 85 17 __ STA P10 
00:8435 : 18 __ __ CLC
00:8436 : 69 01 __ ADC #$01
00:8438 : aa __ __ TAX
00:8439 : ad 5f a7 LDA $a75f ; (cursor + 1)
00:843c : 85 18 __ STA P11 
00:843e : 69 00 __ ADC #$00
00:8440 : 4c 22 82 JMP $8222 ; (main.s36 + 0)
.s81:
00:8443 : b0 eb __ BCS $8430 ; (main.s78 + 0)
00:8445 : 4c 98 81 JMP $8198 ; (main.l12 + 0)
.s83:
00:8448 : a5 1b __ LDA ACCU + 0 
00:844a : c9 64 __ CMP #$64
00:844c : f0 bf __ BEQ $840d ; (main.s77 + 0)
.s84:
00:844e : a9 9b __ LDA #$9b
00:8450 : a2 74 __ LDX #$74
00:8452 : 4c cc 81 JMP $81cc ; (main.s19 + 0)
.s15:
00:8455 : a9 00 __ LDA #$00
00:8457 : 85 56 __ STA T1 + 1 
00:8459 : a5 1b __ LDA ACCU + 0 
00:845b : c9 64 __ CMP #$64
00:845d : f0 ae __ BEQ $840d ; (main.s77 + 0)
.s86:
00:845f : a9 14 __ LDA #$14
00:8461 : a2 54 __ LDX #$54
00:8463 : 4c cc 81 JMP $81cc ; (main.s19 + 0)
--------------------------------------------------------------------
clear_screen: ; clear_screen()->void
;  57, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:8466 : a9 20 __ LDA #$20
00:8468 : a2 fa __ LDX #$fa
.l6:
00:846a : ca __ __ DEX
00:846b : 9d 00 04 STA $0400,x 
00:846e : 9d fa 04 STA $04fa,x 
00:8471 : 9d f4 05 STA $05f4,x 
00:8474 : 9d ee 06 STA $06ee,x 
00:8477 : d0 f1 __ BNE $846a ; (clear_screen.l6 + 0)
.s5:
00:8479 : a9 0e __ LDA #$0e
00:847b : a2 fa __ LDX #$fa
.l7:
00:847d : ca __ __ DEX
00:847e : 9d 00 d8 STA $d800,x 
00:8481 : 9d fa d8 STA $d8fa,x 
00:8484 : 9d f4 d9 STA $d9f4,x 
00:8487 : 9d ee da STA $daee,x 
00:848a : d0 f1 __ BNE $847d ; (clear_screen.l7 + 0)
.s3:
00:848c : 60 __ __ RTS
--------------------------------------------------------------------
debug_key: ; debug_key(u8,bool)->void
; 346, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:848d : a5 18 __ LDA P11 ; (k + 0)
00:848f : 8d f8 46 STA $46f8 ; (sstack + 2)
00:8492 : c9 40 __ CMP #$40
00:8494 : a9 00 __ LDA #$00
00:8496 : 8d f9 46 STA $46f9 ; (sstack + 3)
00:8499 : a9 ef __ LDA #$ef
00:849b : 8d f6 46 STA $46f6 ; (sstack + 0)
00:849e : a9 99 __ LDA #$99
00:84a0 : 8d f7 46 STA $46f7 ; (sstack + 1)
00:84a3 : 90 04 __ BCC $84a9 ; (debug_key.s7 + 0)
.s5:
00:84a5 : a9 3f __ LDA #$3f
00:84a7 : b0 10 __ BCS $84b9 ; (debug_key.s6 + 0)
.s7:
00:84a9 : ad fe 46 LDA $46fe ; (sstack + 8)
00:84ac : f0 06 __ BEQ $84b4 ; (debug_key.s8 + 0)
.s9:
00:84ae : a5 18 __ LDA P11 ; (k + 0)
00:84b0 : 69 40 __ ADC #$40
00:84b2 : 85 18 __ STA P11 ; (k + 0)
.s8:
00:84b4 : a6 18 __ LDX P11 ; (k + 0)
00:84b6 : bd 00 a8 LDA $a800,x ; (keyb_codes[0] + 0)
.s6:
00:84b9 : 8d fa 46 STA $46fa ; (sstack + 4)
00:84bc : a9 b8 __ LDA #$b8
00:84be : 85 16 __ STA P9 
00:84c0 : a9 00 __ LDA #$00
00:84c2 : 8d fb 46 STA $46fb ; (sstack + 5)
00:84c5 : a9 46 __ LDA #$46
00:84c7 : 85 17 __ STA P10 
00:84c9 : 20 2d 8f JSR $8f2d ; (sprintf.s1 + 0)
00:84cc : a9 1c __ LDA #$1c
00:84ce : 85 0d __ STA P0 
00:84d0 : a9 46 __ LDA #$46
00:84d2 : 85 10 __ STA P3 
00:84d4 : a9 18 __ LDA #$18
00:84d6 : 85 0e __ STA P1 
00:84d8 : a9 b8 __ LDA #$b8
00:84da : 85 0f __ STA P2 
--------------------------------------------------------------------
print_at: ; print_at(u8,u8,const u8*)->void
;  63, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:84dc : a5 0e __ LDA P1 ; (y + 0)
00:84de : 0a __ __ ASL
00:84df : 85 1b __ STA ACCU + 0 
00:84e1 : a9 00 __ LDA #$00
00:84e3 : 2a __ __ ROL
00:84e4 : 06 1b __ ASL ACCU + 0 
00:84e6 : 2a __ __ ROL
00:84e7 : aa __ __ TAX
00:84e8 : a5 1b __ LDA ACCU + 0 
00:84ea : 65 0e __ ADC P1 ; (y + 0)
00:84ec : 85 43 __ STA T1 + 0 
00:84ee : 8a __ __ TXA
00:84ef : 69 00 __ ADC #$00
00:84f1 : 06 43 __ ASL T1 + 0 
00:84f3 : 2a __ __ ROL
00:84f4 : 06 43 __ ASL T1 + 0 
00:84f6 : 2a __ __ ROL
00:84f7 : 06 43 __ ASL T1 + 0 
00:84f9 : 2a __ __ ROL
00:84fa : aa __ __ TAX
00:84fb : a0 00 __ LDY #$00
00:84fd : b1 0f __ LDA (P2),y ; (text + 0)
00:84ff : f0 4e __ BEQ $854f ; (print_at.s3 + 0)
.s14:
00:8501 : a5 43 __ LDA T1 + 0 
00:8503 : 65 0d __ ADC P0 ; (x + 0)
00:8505 : 85 43 __ STA T1 + 0 
00:8507 : 8a __ __ TXA
00:8508 : 69 04 __ ADC #$04
00:850a : 85 44 __ STA T1 + 1 
00:850c : a6 0f __ LDX P2 ; (text + 0)
.l5:
00:850e : 86 1b __ STX ACCU + 0 
00:8510 : 8a __ __ TXA
00:8511 : 18 __ __ CLC
00:8512 : 69 01 __ ADC #$01
00:8514 : aa __ __ TAX
00:8515 : a5 10 __ LDA P3 ; (text + 1)
00:8517 : 85 1c __ STA ACCU + 1 
00:8519 : 69 00 __ ADC #$00
00:851b : 85 10 __ STA P3 ; (text + 1)
00:851d : a0 00 __ LDY #$00
00:851f : b1 1b __ LDA (ACCU + 0),y 
00:8521 : c9 61 __ CMP #$61
00:8523 : 90 09 __ BCC $852e ; (print_at.s6 + 0)
.s12:
00:8525 : c9 7b __ CMP #$7b
00:8527 : b0 05 __ BCS $852e ; (print_at.s6 + 0)
.s13:
00:8529 : 69 a0 __ ADC #$a0
00:852b : 4c 41 85 JMP $8541 ; (print_at.s7 + 0)
.s6:
00:852e : c9 41 __ CMP #$41
00:8530 : 90 0f __ BCC $8541 ; (print_at.s7 + 0)
.s8:
00:8532 : c9 5b __ CMP #$5b
00:8534 : b0 05 __ BCS $853b ; (print_at.s9 + 0)
.s11:
00:8536 : 69 c0 __ ADC #$c0
00:8538 : 4c 41 85 JMP $8541 ; (print_at.s7 + 0)
.s9:
00:853b : c9 7c __ CMP #$7c
00:853d : d0 02 __ BNE $8541 ; (print_at.s7 + 0)
.s10:
00:853f : a9 20 __ LDA #$20
.s7:
00:8541 : 91 43 __ STA (T1 + 0),y 
00:8543 : e6 43 __ INC T1 + 0 
00:8545 : d0 02 __ BNE $8549 ; (print_at.s16 + 0)
.s15:
00:8547 : e6 44 __ INC T1 + 1 
.s16:
00:8549 : a0 01 __ LDY #$01
00:854b : b1 1b __ LDA (ACCU + 0),y 
00:854d : d0 bf __ BNE $850e ; (print_at.l5 + 0)
.s3:
00:854f : 60 __ __ RTS
--------------------------------------------------------------------
00:8550 : __ __ __ BYT 61 73 73 65 6d 62 6c 79 36 34 20 62 72 6f 77 73 : assembly64 brows
00:8560 : __ __ __ BYT 65 72 00                                        : er.
--------------------------------------------------------------------
00:8563 : __ __ __ BYT 63 68 65 63 6b 69 6e 67 20 75 6c 74 69 6d 61 74 : checking ultimat
00:8573 : __ __ __ BYT 65 2e 2e 2e 00                                  : e....
--------------------------------------------------------------------
uci_sendcommand: ; uci_sendcommand(u8*,i16)->void
; 119, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:8578 : ad ff 99 LDA $99ff ; (uci_target + 0)
00:857b : a0 00 __ LDY #$00
00:857d : 91 0d __ STA (P0),y ; (bytes + 0)
.l5:
00:857f : ad 1c df LDA $df1c 
00:8582 : 29 20 __ AND #$20
00:8584 : d0 f9 __ BNE $857f ; (uci_sendcommand.l5 + 0)
.s6:
00:8586 : ad 1c df LDA $df1c 
00:8589 : 29 10 __ AND #$10
00:858b : d0 f2 __ BNE $857f ; (uci_sendcommand.l5 + 0)
.s7:
00:858d : a5 10 __ LDA P3 ; (count + 1)
00:858f : 30 2a __ BMI $85bb ; (uci_sendcommand.s8 + 0)
.s13:
00:8591 : 05 0f __ ORA P2 ; (count + 0)
00:8593 : f0 26 __ BEQ $85bb ; (uci_sendcommand.s8 + 0)
.s12:
00:8595 : a5 0f __ LDA P2 ; (count + 0)
00:8597 : 85 1b __ STA ACCU + 0 
00:8599 : a5 0d __ LDA P0 ; (bytes + 0)
00:859b : 85 43 __ STA T2 + 0 
00:859d : a5 0e __ LDA P1 ; (bytes + 1)
00:859f : 85 44 __ STA T2 + 1 
00:85a1 : a0 00 __ LDY #$00
00:85a3 : a6 10 __ LDX P3 ; (count + 1)
.l14:
00:85a5 : b1 43 __ LDA (T2 + 0),y 
00:85a7 : 8d 1d df STA $df1d 
00:85aa : c8 __ __ INY
00:85ab : d0 02 __ BNE $85af ; (uci_sendcommand.s19 + 0)
.s18:
00:85ad : e6 44 __ INC T2 + 1 
.s19:
00:85af : a5 1b __ LDA ACCU + 0 
00:85b1 : d0 01 __ BNE $85b4 ; (uci_sendcommand.s16 + 0)
.s15:
00:85b3 : ca __ __ DEX
.s16:
00:85b4 : c6 1b __ DEC ACCU + 0 
00:85b6 : d0 ed __ BNE $85a5 ; (uci_sendcommand.l14 + 0)
.s17:
00:85b8 : 8a __ __ TXA
00:85b9 : d0 ea __ BNE $85a5 ; (uci_sendcommand.l14 + 0)
.s8:
00:85bb : a9 01 __ LDA #$01
00:85bd : 8d 1c df STA $df1c 
00:85c0 : ad 1c df LDA $df1c 
00:85c3 : 29 08 __ AND #$08
00:85c5 : f0 07 __ BEQ $85ce ; (uci_sendcommand.l9 + 0)
.s11:
00:85c7 : a9 08 __ LDA #$08
00:85c9 : 8d 1c df STA $df1c 
00:85cc : d0 b1 __ BNE $857f ; (uci_sendcommand.l5 + 0)
.l9:
00:85ce : ad 1c df LDA $df1c 
00:85d1 : 29 20 __ AND #$20
00:85d3 : d0 07 __ BNE $85dc ; (uci_sendcommand.s3 + 0)
.s10:
00:85d5 : ad 1c df LDA $df1c 
00:85d8 : 29 10 __ AND #$10
00:85da : d0 f2 __ BNE $85ce ; (uci_sendcommand.l9 + 0)
.s3:
00:85dc : 60 __ __ RTS
--------------------------------------------------------------------
uci_readdata: ; uci_readdata()->void
; 120, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:85dd : a9 00 __ LDA #$00
00:85df : 8d 00 09 STA $0900 ; (uci_data[0] + 0)
00:85e2 : a2 00 __ LDX #$00
00:85e4 : 86 1b __ STX ACCU + 0 
00:85e6 : a8 __ __ TAY
00:85e7 : f0 0d __ BEQ $85f6 ; (uci_readdata.l5 + 0)
.s7:
00:85e9 : ad 1e df LDA $df1e 
00:85ec : 91 1b __ STA (ACCU + 0),y 
00:85ee : 98 __ __ TYA
00:85ef : 18 __ __ CLC
00:85f0 : 69 01 __ ADC #$01
00:85f2 : a8 __ __ TAY
00:85f3 : 8a __ __ TXA
00:85f4 : 69 00 __ ADC #$00
.l5:
00:85f6 : aa __ __ TAX
00:85f7 : 18 __ __ CLC
00:85f8 : 69 09 __ ADC #$09
00:85fa : 85 1c __ STA ACCU + 1 
00:85fc : 2c 1c df BIT $df1c 
00:85ff : 30 e8 __ BMI $85e9 ; (uci_readdata.s7 + 0)
.s6:
00:8601 : a9 00 __ LDA #$00
00:8603 : 91 1b __ STA (ACCU + 0),y 
.s3:
00:8605 : 60 __ __ RTS
--------------------------------------------------------------------
uci_readstatus: ; uci_readstatus()->void
; 121, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:8606 : a9 00 __ LDA #$00
00:8608 : 8d 00 10 STA $1000 ; (uci_status[0] + 0)
00:860b : a2 00 __ LDX #$00
00:860d : 86 1b __ STX ACCU + 0 
00:860f : a8 __ __ TAY
00:8610 : f0 0d __ BEQ $861f ; (uci_readstatus.l5 + 0)
.s7:
00:8612 : ad 1f df LDA $df1f 
00:8615 : 91 1b __ STA (ACCU + 0),y 
00:8617 : 98 __ __ TYA
00:8618 : 18 __ __ CLC
00:8619 : 69 01 __ ADC #$01
00:861b : a8 __ __ TAY
00:861c : 8a __ __ TXA
00:861d : 69 00 __ ADC #$00
.l5:
00:861f : aa __ __ TAX
00:8620 : 18 __ __ CLC
00:8621 : 69 10 __ ADC #$10
00:8623 : 85 1c __ STA ACCU + 1 
00:8625 : ad 1c df LDA $df1c 
00:8628 : 29 40 __ AND #$40
00:862a : d0 e6 __ BNE $8612 ; (uci_readstatus.s7 + 0)
.s6:
00:862c : 91 1b __ STA (ACCU + 0),y 
.s3:
00:862e : 60 __ __ RTS
--------------------------------------------------------------------
uci_accept: ; uci_accept()->void
; 122, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:862f : ad 1c df LDA $df1c 
00:8632 : 09 02 __ ORA #$02
00:8634 : 8d 1c df STA $df1c 
.l5:
00:8637 : ad 1c df LDA $df1c 
00:863a : 29 02 __ AND #$02
00:863c : d0 f9 __ BNE $8637 ; (uci_accept.l5 + 0)
.s3:
00:863e : 60 __ __ RTS
--------------------------------------------------------------------
00:863f : __ __ __ BYT 75 6c 74 69 6d 61 74 65 20 69 69 2b 20 6e 6f 74 : ultimate ii+ not
00:864f : __ __ __ BYT 20 66 6f 75 6e 64 21 00                         :  found!.
--------------------------------------------------------------------
00:8657 : __ __ __ BYT 70 72 65 73 73 20 61 6e 79 20 6b 65 79 20 74 6f : press any key to
00:8667 : __ __ __ BYT 20 65 78 69 74 00                               :  exit.
--------------------------------------------------------------------
wait_key: ; wait_key()->void
; 424, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.l5:
00:866d : 20 7e 86 JSR $867e ; (keyb_poll.s4 + 0)
00:8670 : 2c 00 11 BIT $1100 ; (keyb_key + 0)
00:8673 : 30 f8 __ BMI $866d ; (wait_key.l5 + 0)
.l4:
00:8675 : 20 7e 86 JSR $867e ; (keyb_poll.s4 + 0)
00:8678 : 2c 00 11 BIT $1100 ; (keyb_key + 0)
00:867b : 10 f8 __ BPL $8675 ; (wait_key.l4 + 0)
.s3:
00:867d : 60 __ __ RTS
--------------------------------------------------------------------
keyb_poll: ; keyb_poll()->void
; 126, "/usr/local/include/oscar64/c64/keyboard.h"
.s4:
00:867e : a9 00 __ LDA #$00
00:8680 : 8d 00 11 STA $1100 ; (keyb_key + 0)
00:8683 : a9 ff __ LDA #$ff
00:8685 : 8d 02 dc STA $dc02 
00:8688 : 8d 00 dc STA $dc00 
00:868b : ae 01 dc LDX $dc01 
00:868e : e8 __ __ INX
00:868f : d0 25 __ BNE $86b6 ; (keyb_poll.s3 + 0)
.s5:
00:8691 : 8e 03 dc STX $dc03 
00:8694 : 8e 00 dc STX $dc00 
00:8697 : ad 01 dc LDA $dc01 
00:869a : c9 ff __ CMP #$ff
00:869c : d0 1f __ BNE $86bd ; (keyb_poll.s7 + 0)
.s6:
00:869e : 8d 01 11 STA $1101 ; (keyb_matrix[0] + 0)
00:86a1 : 8d 02 11 STA $1102 ; (keyb_matrix[0] + 1)
00:86a4 : 8d 03 11 STA $1103 ; (keyb_matrix[0] + 2)
00:86a7 : 8d 04 11 STA $1104 ; (keyb_matrix[0] + 3)
00:86aa : 8d 05 11 STA $1105 ; (keyb_matrix[0] + 4)
00:86ad : 8d 06 11 STA $1106 ; (keyb_matrix[0] + 5)
00:86b0 : 8d 07 11 STA $1107 ; (keyb_matrix[0] + 6)
00:86b3 : 8d 08 11 STA $1108 ; (keyb_matrix[0] + 7)
.s3:
00:86b6 : ad 09 11 LDA $1109 ; (ciaa_pra_def + 0)
00:86b9 : 8d 00 dc STA $dc00 
00:86bc : 60 __ __ RTS
.s7:
00:86bd : ad 07 11 LDA $1107 ; (keyb_matrix[0] + 6)
00:86c0 : 29 ef __ AND #$ef
00:86c2 : 8d 07 11 STA $1107 ; (keyb_matrix[0] + 6)
00:86c5 : ad 02 11 LDA $1102 ; (keyb_matrix[0] + 1)
00:86c8 : 29 7f __ AND #$7f
00:86ca : 8d 02 11 STA $1102 ; (keyb_matrix[0] + 1)
00:86cd : a9 fe __ LDA #$fe
00:86cf : 85 1b __ STA ACCU + 0 
.l20:
00:86d1 : a5 1b __ LDA ACCU + 0 
00:86d3 : 8d 00 dc STA $dc00 
00:86d6 : bd 01 11 LDA $1101,x ; (keyb_matrix[0] + 0)
00:86d9 : 85 1c __ STA ACCU + 1 
00:86db : ad 01 dc LDA $dc01 
00:86de : 9d 01 11 STA $1101,x ; (keyb_matrix[0] + 0)
00:86e1 : 38 __ __ SEC
00:86e2 : 26 1b __ ROL ACCU + 0 
00:86e4 : 49 ff __ EOR #$ff
00:86e6 : 25 1c __ AND ACCU + 1 
00:86e8 : f0 25 __ BEQ $870f ; (keyb_poll.s8 + 0)
.s13:
00:86ea : 85 1c __ STA ACCU + 1 
00:86ec : 8a __ __ TXA
00:86ed : 0a __ __ ASL
00:86ee : 0a __ __ ASL
00:86ef : 0a __ __ ASL
00:86f0 : 09 80 __ ORA #$80
00:86f2 : a8 __ __ TAY
00:86f3 : a5 1c __ LDA ACCU + 1 
00:86f5 : 29 f0 __ AND #$f0
00:86f7 : f0 04 __ BEQ $86fd ; (keyb_poll.s14 + 0)
.s19:
00:86f9 : 98 __ __ TYA
00:86fa : 09 04 __ ORA #$04
00:86fc : a8 __ __ TAY
.s14:
00:86fd : a5 1c __ LDA ACCU + 1 
00:86ff : 29 cc __ AND #$cc
00:8701 : f0 02 __ BEQ $8705 ; (keyb_poll.s15 + 0)
.s18:
00:8703 : c8 __ __ INY
00:8704 : c8 __ __ INY
.s15:
00:8705 : a5 1c __ LDA ACCU + 1 
00:8707 : 29 aa __ AND #$aa
00:8709 : f0 01 __ BEQ $870c ; (keyb_poll.s16 + 0)
.s17:
00:870b : c8 __ __ INY
.s16:
00:870c : 8c 00 11 STY $1100 ; (keyb_key + 0)
.s8:
00:870f : e8 __ __ INX
00:8710 : e0 08 __ CPX #$08
00:8712 : 90 bd __ BCC $86d1 ; (keyb_poll.l20 + 0)
.s9:
00:8714 : ad 00 11 LDA $1100 ; (keyb_key + 0)
00:8717 : f0 9d __ BEQ $86b6 ; (keyb_poll.s3 + 0)
.s10:
00:8719 : 2c 02 11 BIT $1102 ; (keyb_matrix[0] + 1)
00:871c : 10 07 __ BPL $8725 ; (keyb_poll.s11 + 0)
.s12:
00:871e : ad 07 11 LDA $1107 ; (keyb_matrix[0] + 6)
00:8721 : 29 10 __ AND #$10
00:8723 : d0 91 __ BNE $86b6 ; (keyb_poll.s3 + 0)
.s11:
00:8725 : ad 00 11 LDA $1100 ; (keyb_key + 0)
00:8728 : 09 40 __ ORA #$40
00:872a : 8d 00 11 STA $1100 ; (keyb_key + 0)
00:872d : b0 87 __ BCS $86b6 ; (keyb_poll.s3 + 0)
--------------------------------------------------------------------
00:872f : __ __ __ BYT 75 6c 74 69 6d 61 74 65 20 69 69 2b 20 64 65 74 : ultimate ii+ det
00:873f : __ __ __ BYT 65 63 74 65 64 00                               : ected.
--------------------------------------------------------------------
00:8745 : __ __ __ BYT 67 65 74 74 69 6e 67 20 69 70 20 61 64 64 72 65 : getting ip addre
00:8755 : __ __ __ BYT 73 73 2e 2e 2e 00                               : ss....
--------------------------------------------------------------------
uci_getipaddress: ; uci_getipaddress()->void
; 154, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:875b : a9 00 __ LDA #$00
00:875d : 8d f5 46 STA $46f5 ; (cmd[0] + 2)
00:8760 : 85 10 __ STA P3 
00:8762 : 8d f3 46 STA $46f3 ; (cmd[0] + 0)
00:8765 : a9 05 __ LDA #$05
00:8767 : 8d f4 46 STA $46f4 ; (cmd[0] + 1)
00:876a : ad ff 99 LDA $99ff ; (uci_target + 0)
00:876d : 85 45 __ STA T1 + 0 
00:876f : a9 03 __ LDA #$03
00:8771 : 85 0f __ STA P2 
00:8773 : 8d ff 99 STA $99ff ; (uci_target + 0)
00:8776 : a9 f3 __ LDA #$f3
00:8778 : 85 0d __ STA P0 
00:877a : a9 46 __ LDA #$46
00:877c : 85 0e __ STA P1 
00:877e : 20 78 85 JSR $8578 ; (uci_sendcommand.s4 + 0)
00:8781 : 20 dd 85 JSR $85dd ; (uci_readdata.s4 + 0)
00:8784 : 20 06 86 JSR $8606 ; (uci_readstatus.s4 + 0)
00:8787 : 20 2f 86 JSR $862f ; (uci_accept.s4 + 0)
00:878a : a5 45 __ LDA T1 + 0 
00:878c : 8d ff 99 STA $99ff ; (uci_target + 0)
.s3:
00:878f : 60 __ __ RTS
--------------------------------------------------------------------
00:8790 : __ __ __ BYT 69 70 3a 20 00                                  : ip: .
--------------------------------------------------------------------
00:8795 : __ __ __ BYT 70 72 65 73 73 20 61 6e 79 20 6b 65 79 20 74 6f : press any key to
00:87a5 : __ __ __ BYT 20 63 6f 6e 6e 65 63 74 00                      :  connect.
--------------------------------------------------------------------
connect_to_server: ; connect_to_server()->bool
; 113, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:87ae : 20 10 88 JSR $8810 ; (clear_line@proxy + 0)
00:87b1 : a9 88 __ LDA #$88
00:87b3 : 85 10 __ STA P3 
00:87b5 : a9 02 __ LDA #$02
00:87b7 : 85 0f __ STA P2 
00:87b9 : 20 2f 9e JSR $9e2f ; (print_at@proxy + 0)
00:87bc : 20 40 88 JSR $8840 ; (uci_tcp_connect.s4 + 0)
00:87bf : 8d 58 a7 STA $a758 ; (socket_id + 0)
00:87c2 : ad 00 10 LDA $1000 ; (uci_status[0] + 0)
00:87c5 : c9 30 __ CMP #$30
00:87c7 : d0 26 __ BNE $87ef ; (connect_to_server.s5 + 0)
.s6:
00:87c9 : ad 01 10 LDA $1001 ; (uci_status[0] + 1)
00:87cc : c9 30 __ CMP #$30
00:87ce : d0 1f __ BNE $87ef ; (connect_to_server.s5 + 0)
.s7:
00:87d0 : ad 58 a7 LDA $a758 ; (socket_id + 0)
00:87d3 : 85 11 __ STA P4 
00:87d5 : a9 01 __ LDA #$01
00:87d7 : 8d 59 a7 STA $a759 ; (connected + 0)
00:87da : 20 22 89 JSR $8922 ; (uci_tcp_nextline.s4 + 0)
00:87dd : 20 14 88 JSR $8814 ; (clear_line.s4 + 0)
00:87e0 : a9 8a __ LDA #$8a
00:87e2 : 85 10 __ STA P3 
00:87e4 : a9 00 __ LDA #$00
00:87e6 : 85 0f __ STA P2 
00:87e8 : 20 2f 9e JSR $9e2f ; (print_at@proxy + 0)
00:87eb : a9 01 __ LDA #$01
00:87ed : d0 10 __ BNE $87ff ; (connect_to_server.s3 + 0)
.s5:
00:87ef : 20 14 88 JSR $8814 ; (clear_line.s4 + 0)
00:87f2 : a9 89 __ LDA #$89
00:87f4 : 85 10 __ STA P3 
00:87f6 : a9 0d __ LDA #$0d
00:87f8 : 85 0f __ STA P2 
00:87fa : 20 2f 9e JSR $9e2f ; (print_at@proxy + 0)
00:87fd : a9 00 __ LDA #$00
.s3:
00:87ff : 85 1b __ STA ACCU + 0 
00:8801 : 60 __ __ RTS
--------------------------------------------------------------------
00:8802 : __ __ __ BYT 63 6f 6e 6e 65 63 74 69 6e 67 2e 2e 2e 00       : connecting....
--------------------------------------------------------------------
clear_line@proxy: ; clear_line@proxy
00:8810 : a9 18 __ LDA #$18
00:8812 : 85 13 __ STA P6 
--------------------------------------------------------------------
clear_line: ; clear_line(u8)->void
;  98, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:8814 : a5 13 __ LDA P6 ; (y + 0)
00:8816 : 0a __ __ ASL
00:8817 : 85 1b __ STA ACCU + 0 
00:8819 : a9 00 __ LDA #$00
00:881b : 2a __ __ ROL
00:881c : 06 1b __ ASL ACCU + 0 
00:881e : 2a __ __ ROL
00:881f : aa __ __ TAX
00:8820 : a5 1b __ LDA ACCU + 0 
00:8822 : 65 13 __ ADC P6 ; (y + 0)
00:8824 : 85 1b __ STA ACCU + 0 
00:8826 : 8a __ __ TXA
00:8827 : 69 00 __ ADC #$00
00:8829 : 06 1b __ ASL ACCU + 0 
00:882b : 2a __ __ ROL
00:882c : 06 1b __ ASL ACCU + 0 
00:882e : 2a __ __ ROL
00:882f : 06 1b __ ASL ACCU + 0 
00:8831 : 2a __ __ ROL
00:8832 : 69 04 __ ADC #$04
00:8834 : 85 1c __ STA ACCU + 1 
00:8836 : a9 20 __ LDA #$20
00:8838 : a0 28 __ LDY #$28
.l5:
00:883a : 88 __ __ DEY
00:883b : 91 1b __ STA (ACCU + 0),y 
00:883d : d0 fb __ BNE $883a ; (clear_line.l5 + 0)
.s3:
00:883f : 60 __ __ RTS
--------------------------------------------------------------------
uci_tcp_connect: ; uci_tcp_connect(const u8*,u16)->u8
; 157, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:8840 : a9 00 __ LDA #$00
00:8842 : 85 0d __ STA P0 
00:8844 : a9 89 __ LDA #$89
00:8846 : 85 0e __ STA P1 
00:8848 : 20 df 88 JSR $88df ; (strlen.s4 + 0)
00:884b : a5 1b __ LDA ACCU + 0 
00:884d : 85 43 __ STA T0 + 0 
00:884f : 18 __ __ CLC
00:8850 : 69 05 __ ADC #$05
00:8852 : 85 0f __ STA P2 
00:8854 : 85 1b __ STA ACCU + 0 
00:8856 : a5 1c __ LDA ACCU + 1 
00:8858 : 85 44 __ STA T0 + 1 
00:885a : 69 00 __ ADC #$00
00:885c : 85 10 __ STA P3 
00:885e : 85 1c __ STA ACCU + 1 
00:8860 : 20 7c a5 JSR $a57c ; (crt_malloc + 0)
00:8863 : a9 00 __ LDA #$00
00:8865 : a8 __ __ TAY
00:8866 : 91 1b __ STA (ACCU + 0),y 
00:8868 : a9 07 __ LDA #$07
00:886a : c8 __ __ INY
00:886b : 91 1b __ STA (ACCU + 0),y 
00:886d : a9 41 __ LDA #$41
00:886f : c8 __ __ INY
00:8870 : 91 1b __ STA (ACCU + 0),y 
00:8872 : a9 19 __ LDA #$19
00:8874 : c8 __ __ INY
00:8875 : 91 1b __ STA (ACCU + 0),y 
00:8877 : ad ff 99 LDA $99ff ; (uci_target + 0)
00:887a : 85 45 __ STA T6 + 0 
00:887c : a5 44 __ LDA T0 + 1 
00:887e : 30 1d __ BMI $889d ; (uci_tcp_connect.s5 + 0)
.s8:
00:8880 : 05 43 __ ORA T0 + 0 
00:8882 : f0 19 __ BEQ $889d ; (uci_tcp_connect.s5 + 0)
.s6:
00:8884 : a2 00 __ LDX #$00
00:8886 : 18 __ __ CLC
.l10:
00:8887 : 8a __ __ TXA
00:8888 : 69 04 __ ADC #$04
00:888a : a8 __ __ TAY
00:888b : bd 00 89 LDA $8900,x 
00:888e : 91 1b __ STA (ACCU + 0),y 
00:8890 : a9 00 __ LDA #$00
00:8892 : e8 __ __ INX
00:8893 : c5 44 __ CMP T0 + 1 
00:8895 : 90 f0 __ BCC $8887 ; (uci_tcp_connect.l10 + 0)
.s9:
00:8897 : d0 04 __ BNE $889d ; (uci_tcp_connect.s5 + 0)
.s7:
00:8899 : e4 43 __ CPX T0 + 0 
00:889b : 90 ea __ BCC $8887 ; (uci_tcp_connect.l10 + 0)
.s5:
00:889d : a5 1b __ LDA ACCU + 0 
00:889f : 85 0d __ STA P0 
00:88a1 : 18 __ __ CLC
00:88a2 : 65 43 __ ADC T0 + 0 
00:88a4 : 85 43 __ STA T0 + 0 
00:88a6 : a5 1c __ LDA ACCU + 1 
00:88a8 : 85 0e __ STA P1 
00:88aa : 65 44 __ ADC T0 + 1 
00:88ac : 85 44 __ STA T0 + 1 
00:88ae : a9 00 __ LDA #$00
00:88b0 : a0 04 __ LDY #$04
00:88b2 : 91 43 __ STA (T0 + 0),y 
00:88b4 : a9 03 __ LDA #$03
00:88b6 : 8d ff 99 STA $99ff ; (uci_target + 0)
00:88b9 : 20 78 85 JSR $8578 ; (uci_sendcommand.s4 + 0)
00:88bc : 20 4a a6 JSR $a64a ; (crt_free@proxy + 0)
00:88bf : 20 dd 85 JSR $85dd ; (uci_readdata.s4 + 0)
00:88c2 : 20 06 86 JSR $8606 ; (uci_readstatus.s4 + 0)
00:88c5 : 20 2f 86 JSR $862f ; (uci_accept.s4 + 0)
00:88c8 : a9 00 __ LDA #$00
00:88ca : 8d 56 a7 STA $a756 ; (uci_data_len + 0)
00:88cd : 8d 57 a7 STA $a757 ; (uci_data_len + 1)
00:88d0 : 8d 54 a7 STA $a754 ; (uci_data_index + 0)
00:88d3 : 8d 55 a7 STA $a755 ; (uci_data_index + 1)
00:88d6 : a5 45 __ LDA T6 + 0 
00:88d8 : 8d ff 99 STA $99ff ; (uci_target + 0)
00:88db : ad 00 09 LDA $0900 ; (uci_data[0] + 0)
.s3:
00:88de : 60 __ __ RTS
--------------------------------------------------------------------
strlen: ; strlen(const u8*)->i16
;  12, "/usr/local/include/oscar64/string.h"
.s4:
00:88df : a9 00 __ LDA #$00
00:88e1 : 85 1b __ STA ACCU + 0 
00:88e3 : 85 1c __ STA ACCU + 1 
00:88e5 : a8 __ __ TAY
00:88e6 : b1 0d __ LDA (P0),y ; (str + 0)
00:88e8 : f0 10 __ BEQ $88fa ; (strlen.s3 + 0)
.s6:
00:88ea : a2 00 __ LDX #$00
.l7:
00:88ec : c8 __ __ INY
00:88ed : d0 03 __ BNE $88f2 ; (strlen.s9 + 0)
.s8:
00:88ef : e6 0e __ INC P1 ; (str + 1)
00:88f1 : e8 __ __ INX
.s9:
00:88f2 : b1 0d __ LDA (P0),y ; (str + 0)
00:88f4 : d0 f6 __ BNE $88ec ; (strlen.l7 + 0)
.s5:
00:88f6 : 86 1c __ STX ACCU + 1 
00:88f8 : 84 1b __ STY ACCU + 0 
.s3:
00:88fa : 60 __ __ RTS
--------------------------------------------------------------------
00:88fb : __ __ __ BYT 43 41 54 53 00                                  : CATS.
--------------------------------------------------------------------
00:8900 : __ __ __ BYT 31 39 32 2e 31 36 38 2e 32 2e 36 36 00          : 192.168.2.66.
--------------------------------------------------------------------
00:890d : __ __ __ BYT 63 6f 6e 6e 65 63 74 20 66 61 69 6c 65 64 21 00 : connect failed!.
--------------------------------------------------------------------
read_line: ; read_line()->void
; 157, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:891d : ad 58 a7 LDA $a758 ; (socket_id + 0)
00:8920 : 85 11 __ STA P4 
--------------------------------------------------------------------
uci_tcp_nextline: ; uci_tcp_nextline(u8,u8*)->void
; 173, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:8922 : a9 00 __ LDA #$00
00:8924 : 8d 0a 11 STA $110a ; (line_buffer[0] + 0)
00:8927 : 85 46 __ STA T2 + 0 
.l5:
00:8929 : ad 54 a7 LDA $a754 ; (uci_data_index + 0)
00:892c : 85 43 __ STA T0 + 0 
00:892e : ad 55 a7 LDA $a755 ; (uci_data_index + 1)
00:8931 : 85 44 __ STA T0 + 1 
00:8933 : cd 57 a7 CMP $a757 ; (uci_data_len + 1)
00:8936 : d0 0a __ BNE $8942 ; (uci_tcp_nextline.s18 + 0)
.s15:
00:8938 : a5 43 __ LDA T0 + 0 
00:893a : cd 56 a7 CMP $a756 ; (uci_data_len + 0)
.s16:
00:893d : b0 0a __ BCS $8949 ; (uci_tcp_nextline.l6 + 0)
00:893f : 4c d2 89 JMP $89d2 ; (uci_tcp_nextline.s14 + 0)
.s18:
00:8942 : 4d 57 a7 EOR $a757 ; (uci_data_len + 1)
00:8945 : 10 f6 __ BPL $893d ; (uci_tcp_nextline.s16 + 0)
.s17:
00:8947 : b0 f6 __ BCS $893f ; (uci_tcp_nextline.s16 + 2)
.l6:
00:8949 : a9 00 __ LDA #$00
00:894b : 85 10 __ STA P3 
00:894d : 8d f1 46 STA $46f1 ; (cmd[0] + 0)
00:8950 : a9 05 __ LDA #$05
00:8952 : 85 0f __ STA P2 
00:8954 : a9 10 __ LDA #$10
00:8956 : 8d f2 46 STA $46f2 ; (cmd[0] + 1)
00:8959 : a5 11 __ LDA P4 ; (socketid + 0)
00:895b : 8d f3 46 STA $46f3 ; (cmd[0] + 2)
00:895e : a9 7c __ LDA #$7c
00:8960 : 8d f4 46 STA $46f4 ; (cmd[0] + 3)
00:8963 : ad ff 99 LDA $99ff ; (uci_target + 0)
00:8966 : 85 45 __ STA T1 + 0 
00:8968 : a9 03 __ LDA #$03
00:896a : 8d f5 46 STA $46f5 ; (cmd[0] + 4)
00:896d : 8d ff 99 STA $99ff ; (uci_target + 0)
00:8970 : a9 f1 __ LDA #$f1
00:8972 : 85 0d __ STA P0 
00:8974 : a9 46 __ LDA #$46
00:8976 : 85 0e __ STA P1 
00:8978 : 20 78 85 JSR $8578 ; (uci_sendcommand.s4 + 0)
00:897b : 20 dd 85 JSR $85dd ; (uci_readdata.s4 + 0)
00:897e : 20 06 86 JSR $8606 ; (uci_readstatus.s4 + 0)
00:8981 : 20 2f 86 JSR $862f ; (uci_accept.s4 + 0)
00:8984 : a5 45 __ LDA T1 + 0 
00:8986 : 8d ff 99 STA $99ff ; (uci_target + 0)
00:8989 : ad 00 09 LDA $0900 ; (uci_data[0] + 0)
00:898c : 8d 56 a7 STA $a756 ; (uci_data_len + 0)
00:898f : ad 01 09 LDA $0901 ; (uci_data[0] + 1)
00:8992 : 8d 57 a7 STA $a757 ; (uci_data_len + 1)
00:8995 : 0d 00 09 ORA $0900 ; (uci_data[0] + 0)
00:8998 : f0 30 __ BEQ $89ca ; (uci_tcp_nextline.s9 + 0)
.s7:
00:899a : ae 01 09 LDX $0901 ; (uci_data[0] + 1)
00:899d : e8 __ __ INX
00:899e : d0 06 __ BNE $89a6 ; (uci_tcp_nextline.s8 + 0)
.s13:
00:89a0 : ae 56 a7 LDX $a756 ; (uci_data_len + 0)
00:89a3 : e8 __ __ INX
00:89a4 : f0 a3 __ BEQ $8949 ; (uci_tcp_nextline.l6 + 0)
.s8:
00:89a6 : a9 01 __ LDA #$01
00:89a8 : 8d 54 a7 STA $a754 ; (uci_data_index + 0)
00:89ab : a9 00 __ LDA #$00
00:89ad : 8d 55 a7 STA $a755 ; (uci_data_index + 1)
00:89b0 : ad 02 09 LDA $0902 ; (uci_data[0] + 2)
00:89b3 : f0 15 __ BEQ $89ca ; (uci_tcp_nextline.s9 + 0)
.s10:
00:89b5 : c9 0a __ CMP #$0a
00:89b7 : f0 11 __ BEQ $89ca ; (uci_tcp_nextline.s9 + 0)
.s11:
00:89b9 : c9 0d __ CMP #$0d
00:89bb : d0 03 __ BNE $89c0 ; (uci_tcp_nextline.s12 + 0)
00:89bd : 4c 29 89 JMP $8929 ; (uci_tcp_nextline.l5 + 0)
.s12:
00:89c0 : a6 46 __ LDX T2 + 0 
00:89c2 : 9d 0a 11 STA $110a,x ; (line_buffer[0] + 0)
00:89c5 : e6 46 __ INC T2 + 0 
00:89c7 : 4c 29 89 JMP $8929 ; (uci_tcp_nextline.l5 + 0)
.s9:
00:89ca : a9 00 __ LDA #$00
00:89cc : a6 46 __ LDX T2 + 0 
00:89ce : 9d 0a 11 STA $110a,x ; (line_buffer[0] + 0)
.s3:
00:89d1 : 60 __ __ RTS
.s14:
00:89d2 : 18 __ __ CLC
00:89d3 : a5 43 __ LDA T0 + 0 
00:89d5 : 69 01 __ ADC #$01
00:89d7 : 8d 54 a7 STA $a754 ; (uci_data_index + 0)
00:89da : a5 44 __ LDA T0 + 1 
00:89dc : 69 00 __ ADC #$00
00:89de : 8d 55 a7 STA $a755 ; (uci_data_index + 1)
00:89e1 : 18 __ __ CLC
00:89e2 : a9 02 __ LDA #$02
00:89e4 : 65 43 __ ADC T0 + 0 
00:89e6 : 85 43 __ STA T0 + 0 
00:89e8 : a9 09 __ LDA #$09
00:89ea : 65 44 __ ADC T0 + 1 
00:89ec : 85 44 __ STA T0 + 1 
00:89ee : a0 00 __ LDY #$00
00:89f0 : b1 43 __ LDA (T0 + 0),y 
00:89f2 : f0 d6 __ BEQ $89ca ; (uci_tcp_nextline.s9 + 0)
00:89f4 : d0 bf __ BNE $89b5 ; (uci_tcp_nextline.s10 + 0)
--------------------------------------------------------------------
00:89f6 : __ __ __ BYT 72 65 61 64 79 00                               : ready.
--------------------------------------------------------------------
00:89fc : __ __ __ BYT 5f 00                                           : _.
--------------------------------------------------------------------
00:89fe : __ __ __ BYT 3e 00                                           : >.
--------------------------------------------------------------------
00:8a00 : __ __ __ BYT 63 6f 6e 6e 65 63 74 65 64 21 00                : connected!.
--------------------------------------------------------------------
load_categories: ; load_categories()->void
; 171, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:8a0b : 20 10 88 JSR $8810 ; (clear_line@proxy + 0)
00:8a0e : a9 8b __ LDA #$8b
00:8a10 : 85 10 __ STA P3 
00:8a12 : a9 00 __ LDA #$00
00:8a14 : 85 0f __ STA P2 
00:8a16 : 20 2f 9e JSR $9e2f ; (print_at@proxy + 0)
00:8a19 : a9 fb __ LDA #$fb
00:8a1b : 85 14 __ STA P7 
00:8a1d : a9 88 __ LDA #$88
00:8a1f : 85 15 __ STA P8 
00:8a21 : 20 16 8b JSR $8b16 ; (send_command.s4 + 0)
00:8a24 : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:8a27 : a9 00 __ LDA #$00
00:8a29 : 8d 5a a7 STA $a75a ; (item_count + 0)
00:8a2c : 8d 5b a7 STA $a75b ; (item_count + 1)
00:8a2f : 20 ec 8a JSR $8aec ; (atoi@proxy + 0)
00:8a32 : a5 1b __ LDA ACCU + 0 
00:8a34 : 8d 5c a7 STA $a75c ; (total_count + 0)
00:8a37 : a5 1c __ LDA ACCU + 1 
00:8a39 : 8d 5d a7 STA $a75d ; (total_count + 1)
.l5:
00:8a3c : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:8a3f : ad 0a 11 LDA $110a ; (line_buffer[0] + 0)
00:8a42 : c9 2e __ CMP #$2e
00:8a44 : f0 7c __ BEQ $8ac2 ; (load_categories.s8 + 0)
.s6:
00:8a46 : 20 80 8c JSR $8c80 ; (strchr@proxy + 0)
00:8a49 : a5 1c __ LDA ACCU + 1 
00:8a4b : 05 1b __ ORA ACCU + 0 
00:8a4d : f0 62 __ BEQ $8ab1 ; (load_categories.s7 + 0)
.s11:
00:8a4f : a5 1c __ LDA ACCU + 1 
00:8a51 : 85 4d __ STA T1 + 1 
00:8a53 : a5 1b __ LDA ACCU + 0 
00:8a55 : 85 4c __ STA T1 + 0 
00:8a57 : a9 00 __ LDA #$00
00:8a59 : a8 __ __ TAY
00:8a5a : 91 1b __ STA (ACCU + 0),y 
00:8a5c : a9 0a __ LDA #$0a
00:8a5e : 85 0f __ STA P2 
00:8a60 : a9 11 __ LDA #$11
00:8a62 : 85 10 __ STA P3 
00:8a64 : ad 5a a7 LDA $a75a ; (item_count + 0)
00:8a67 : 85 4e __ STA T2 + 0 
00:8a69 : 4a __ __ LSR
00:8a6a : 6a __ __ ROR
00:8a6b : 6a __ __ ROR
00:8a6c : aa __ __ TAX
00:8a6d : 29 c0 __ AND #$c0
00:8a6f : 6a __ __ ROR
00:8a70 : 69 8c __ ADC #$8c
00:8a72 : 85 4a __ STA T0 + 0 
00:8a74 : 85 0d __ STA P0 
00:8a76 : 8a __ __ TXA
00:8a77 : 29 1f __ AND #$1f
00:8a79 : 69 11 __ ADC #$11
00:8a7b : 85 4b __ STA T0 + 1 
00:8a7d : 85 0e __ STA P1 
00:8a7f : 20 b2 8c JSR $8cb2 ; (strncpy.s4 + 0)
00:8a82 : a9 00 __ LDA #$00
00:8a84 : a0 1f __ LDY #$1f
00:8a86 : 91 4a __ STA (T0 + 0),y 
00:8a88 : 18 __ __ CLC
00:8a89 : a5 4c __ LDA T1 + 0 
00:8a8b : 69 01 __ ADC #$01
00:8a8d : 85 0d __ STA P0 
00:8a8f : a5 4d __ LDA T1 + 1 
00:8a91 : 69 00 __ ADC #$00
00:8a93 : 85 0e __ STA P1 
00:8a95 : 20 d6 8b JSR $8bd6 ; (atoi.l4 + 0)
00:8a98 : a5 4e __ LDA T2 + 0 
00:8a9a : 0a __ __ ASL
00:8a9b : aa __ __ TAX
00:8a9c : a5 1b __ LDA ACCU + 0 
00:8a9e : 9d 0c 14 STA $140c,x ; (item_ids[0] + 0)
00:8aa1 : a5 1c __ LDA ACCU + 1 
00:8aa3 : 9d 0d 14 STA $140d,x ; (item_ids[0] + 1)
00:8aa6 : a6 4e __ LDX T2 + 0 
00:8aa8 : e8 __ __ INX
00:8aa9 : 8e 5a a7 STX $a75a ; (item_count + 0)
00:8aac : a9 00 __ LDA #$00
00:8aae : 8d 5b a7 STA $a75b ; (item_count + 1)
.s7:
00:8ab1 : ad 5b a7 LDA $a75b ; (item_count + 1)
00:8ab4 : 30 86 __ BMI $8a3c ; (load_categories.l5 + 0)
.s10:
00:8ab6 : d0 0a __ BNE $8ac2 ; (load_categories.s8 + 0)
.s9:
00:8ab8 : ad 5a a7 LDA $a75a ; (item_count + 0)
00:8abb : c9 14 __ CMP #$14
00:8abd : b0 03 __ BCS $8ac2 ; (load_categories.s8 + 0)
00:8abf : 4c 3c 8a JMP $8a3c ; (load_categories.l5 + 0)
.s8:
00:8ac2 : a9 00 __ LDA #$00
00:8ac4 : 8d 62 a7 STA $a762 ; (current_page + 0)
00:8ac7 : 8d 63 a7 STA $a763 ; (current_page + 1)
00:8aca : 8d 60 a7 STA $a760 ; (offset + 0)
00:8acd : 8d 61 a7 STA $a761 ; (offset + 1)
00:8ad0 : 8d 5e a7 STA $a75e ; (cursor + 0)
00:8ad3 : 8d 5f a7 STA $a75f ; (cursor + 1)
00:8ad6 : 20 10 88 JSR $8810 ; (clear_line@proxy + 0)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
00:8ad9 : a9 00 __ LDA #$00
00:8adb : 85 0d __ STA P0 
00:8add : a9 18 __ LDA #$18
00:8adf : 85 0e __ STA P1 
00:8ae1 : a9 f6 __ LDA #$f6
00:8ae3 : 85 0f __ STA P2 
00:8ae5 : a9 89 __ LDA #$89
00:8ae7 : 85 10 __ STA P3 
00:8ae9 : 4c dc 84 JMP $84dc ; (print_at.s4 + 0)
--------------------------------------------------------------------
atoi@proxy: ; atoi@proxy
00:8aec : a9 0d __ LDA #$0d
00:8aee : 85 0d __ STA P0 
00:8af0 : a9 11 __ LDA #$11
00:8af2 : 85 0e __ STA P1 
00:8af4 : 4c d6 8b JMP $8bd6 ; (atoi.l4 + 0)
--------------------------------------------------------------------
00:8af7 : __ __ __ BYT 73 65 61 72 63 68 3a 20 00                      : search: .
--------------------------------------------------------------------
00:8b00 : __ __ __ BYT 6c 6f 61 64 69 6e 67 20 63 61 74 65 67 6f 72 69 : loading categori
00:8b10 : __ __ __ BYT 65 73 2e 2e 2e 00                               : es....
--------------------------------------------------------------------
send_command: ; send_command(const u8*)->void
; 148, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:8b16 : ad 59 a7 LDA $a759 ; (connected + 0)
00:8b19 : d0 01 __ BNE $8b1c ; (send_command.s5 + 0)
.s3:
00:8b1b : 60 __ __ RTS
.s5:
00:8b1c : a5 14 __ LDA P7 ; (cmd + 0)
00:8b1e : 85 12 __ STA P5 
00:8b20 : a5 15 __ LDA P8 ; (cmd + 1)
00:8b22 : 85 13 __ STA P6 
00:8b24 : 20 3a a7 JSR $a73a ; (uci_socket_write@proxy + 0)
00:8b27 : a9 0a __ LDA #$0a
00:8b29 : 8d 8a 11 STA $118a ; (temp_char[0] + 0)
00:8b2c : a9 00 __ LDA #$00
00:8b2e : 8d 8b 11 STA $118b ; (temp_char[0] + 1)
00:8b31 : a9 8a __ LDA #$8a
00:8b33 : 85 12 __ STA P5 
00:8b35 : a9 11 __ LDA #$11
00:8b37 : 85 13 __ STA P6 
--------------------------------------------------------------------
uci_socket_write: ; uci_socket_write(u8,const u8*)->void
; 161, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/ultimate.h"
.s4:
00:8b39 : a5 12 __ LDA P5 ; (data + 0)
00:8b3b : 85 0d __ STA P0 
00:8b3d : 85 47 __ STA T3 + 0 
00:8b3f : a5 13 __ LDA P6 ; (data + 1)
00:8b41 : 85 0e __ STA P1 
00:8b43 : 85 48 __ STA T3 + 1 
00:8b45 : 20 df 88 JSR $88df ; (strlen.s4 + 0)
00:8b48 : a5 1b __ LDA ACCU + 0 
00:8b4a : 85 43 __ STA T0 + 0 
00:8b4c : 18 __ __ CLC
00:8b4d : 69 03 __ ADC #$03
00:8b4f : 85 0f __ STA P2 
00:8b51 : 85 1b __ STA ACCU + 0 
00:8b53 : a5 1c __ LDA ACCU + 1 
00:8b55 : 85 44 __ STA T0 + 1 
00:8b57 : 69 00 __ ADC #$00
00:8b59 : 85 10 __ STA P3 
00:8b5b : 85 1c __ STA ACCU + 1 
00:8b5d : 20 7c a5 JSR $a57c ; (crt_malloc + 0)
00:8b60 : a9 00 __ LDA #$00
00:8b62 : a8 __ __ TAY
00:8b63 : 91 1b __ STA (ACCU + 0),y 
00:8b65 : a9 11 __ LDA #$11
00:8b67 : c8 __ __ INY
00:8b68 : 91 1b __ STA (ACCU + 0),y 
00:8b6a : a5 11 __ LDA P4 ; (socketid + 0)
00:8b6c : c8 __ __ INY
00:8b6d : 91 1b __ STA (ACCU + 0),y 
00:8b6f : ad ff 99 LDA $99ff ; (uci_target + 0)
00:8b72 : 85 49 __ STA T6 + 0 
00:8b74 : a5 44 __ LDA T0 + 1 
00:8b76 : 30 2e __ BMI $8ba6 ; (uci_socket_write.s5 + 0)
.s8:
00:8b78 : 05 43 __ ORA T0 + 0 
00:8b7a : f0 2a __ BEQ $8ba6 ; (uci_socket_write.s5 + 0)
.s6:
00:8b7c : a5 1b __ LDA ACCU + 0 
00:8b7e : 85 45 __ STA T2 + 0 
00:8b80 : a5 1c __ LDA ACCU + 1 
00:8b82 : 85 46 __ STA T2 + 1 
00:8b84 : a6 44 __ LDX T0 + 1 
.l7:
00:8b86 : a0 00 __ LDY #$00
00:8b88 : b1 47 __ LDA (T3 + 0),y 
00:8b8a : a0 03 __ LDY #$03
00:8b8c : 91 45 __ STA (T2 + 0),y 
00:8b8e : e6 45 __ INC T2 + 0 
00:8b90 : d0 02 __ BNE $8b94 ; (uci_socket_write.s13 + 0)
.s12:
00:8b92 : e6 46 __ INC T2 + 1 
.s13:
00:8b94 : e6 47 __ INC T3 + 0 
00:8b96 : d0 02 __ BNE $8b9a ; (uci_socket_write.s15 + 0)
.s14:
00:8b98 : e6 48 __ INC T3 + 1 
.s15:
00:8b9a : a5 43 __ LDA T0 + 0 
00:8b9c : d0 01 __ BNE $8b9f ; (uci_socket_write.s10 + 0)
.s9:
00:8b9e : ca __ __ DEX
.s10:
00:8b9f : c6 43 __ DEC T0 + 0 
00:8ba1 : d0 e3 __ BNE $8b86 ; (uci_socket_write.l7 + 0)
.s11:
00:8ba3 : 8a __ __ TXA
00:8ba4 : d0 e0 __ BNE $8b86 ; (uci_socket_write.l7 + 0)
.s5:
00:8ba6 : a5 1b __ LDA ACCU + 0 
00:8ba8 : 85 0d __ STA P0 
00:8baa : a5 1c __ LDA ACCU + 1 
00:8bac : 85 0e __ STA P1 
00:8bae : a9 03 __ LDA #$03
00:8bb0 : 8d ff 99 STA $99ff ; (uci_target + 0)
00:8bb3 : 20 78 85 JSR $8578 ; (uci_sendcommand.s4 + 0)
00:8bb6 : 20 4a a6 JSR $a64a ; (crt_free@proxy + 0)
00:8bb9 : 20 dd 85 JSR $85dd ; (uci_readdata.s4 + 0)
00:8bbc : 20 06 86 JSR $8606 ; (uci_readstatus.s4 + 0)
00:8bbf : 20 2f 86 JSR $862f ; (uci_accept.s4 + 0)
00:8bc2 : a9 00 __ LDA #$00
00:8bc4 : 8d 56 a7 STA $a756 ; (uci_data_len + 0)
00:8bc7 : 8d 57 a7 STA $a757 ; (uci_data_len + 1)
00:8bca : 8d 54 a7 STA $a754 ; (uci_data_index + 0)
00:8bcd : 8d 55 a7 STA $a755 ; (uci_data_index + 1)
00:8bd0 : a5 49 __ LDA T6 + 0 
00:8bd2 : 8d ff 99 STA $99ff ; (uci_target + 0)
.s3:
00:8bd5 : 60 __ __ RTS
--------------------------------------------------------------------
atoi: ; atoi(const u8*)->i16
;  30, "/usr/local/include/oscar64/stdlib.h"
.l4:
00:8bd6 : a0 00 __ LDY #$00
00:8bd8 : b1 0d __ LDA (P0),y ; (s + 0)
00:8bda : aa __ __ TAX
00:8bdb : a5 0d __ LDA P0 ; (s + 0)
00:8bdd : 85 43 __ STA T0 + 0 
00:8bdf : 18 __ __ CLC
00:8be0 : 69 01 __ ADC #$01
00:8be2 : 85 0d __ STA P0 ; (s + 0)
00:8be4 : a5 0e __ LDA P1 ; (s + 1)
00:8be6 : 85 44 __ STA T0 + 1 
00:8be8 : 69 00 __ ADC #$00
00:8bea : 85 0e __ STA P1 ; (s + 1)
00:8bec : 8a __ __ TXA
00:8bed : e0 21 __ CPX #$21
00:8bef : b0 08 __ BCS $8bf9 ; (atoi.s5 + 0)
.s16:
00:8bf1 : aa __ __ TAX
00:8bf2 : d0 e2 __ BNE $8bd6 ; (atoi.l4 + 0)
.s17:
00:8bf4 : 85 1b __ STA ACCU + 0 
.s3:
00:8bf6 : 85 1c __ STA ACCU + 1 
00:8bf8 : 60 __ __ RTS
.s5:
00:8bf9 : c9 2d __ CMP #$2d
00:8bfb : d0 1d __ BNE $8c1a ; (atoi.s6 + 0)
.s15:
00:8bfd : a9 01 __ LDA #$01
00:8bff : 85 1d __ STA ACCU + 2 
.s14:
00:8c01 : 18 __ __ CLC
00:8c02 : a5 43 __ LDA T0 + 0 
00:8c04 : 69 02 __ ADC #$02
00:8c06 : 85 0d __ STA P0 ; (s + 0)
00:8c08 : a5 44 __ LDA T0 + 1 
00:8c0a : 69 00 __ ADC #$00
00:8c0c : 85 0e __ STA P1 ; (s + 1)
00:8c0e : a0 01 __ LDY #$01
00:8c10 : b1 43 __ LDA (T0 + 0),y 
.s7:
00:8c12 : 85 1c __ STA ACCU + 1 
00:8c14 : a9 00 __ LDA #$00
00:8c16 : 85 43 __ STA T0 + 0 
00:8c18 : f0 08 __ BEQ $8c22 ; (atoi.l8 + 0)
.s6:
00:8c1a : 84 1d __ STY ACCU + 2 
00:8c1c : c9 2b __ CMP #$2b
00:8c1e : d0 f2 __ BNE $8c12 ; (atoi.s7 + 0)
00:8c20 : f0 df __ BEQ $8c01 ; (atoi.s14 + 0)
.l8:
00:8c22 : 85 44 __ STA T0 + 1 
00:8c24 : a5 1c __ LDA ACCU + 1 
00:8c26 : c9 30 __ CMP #$30
00:8c28 : 90 3b __ BCC $8c65 ; (atoi.s9 + 0)
.s12:
00:8c2a : c9 3a __ CMP #$3a
00:8c2c : b0 37 __ BCS $8c65 ; (atoi.s9 + 0)
.s13:
00:8c2e : a0 00 __ LDY #$00
00:8c30 : b1 0d __ LDA (P0),y ; (s + 0)
00:8c32 : a8 __ __ TAY
00:8c33 : e6 0d __ INC P0 ; (s + 0)
00:8c35 : d0 02 __ BNE $8c39 ; (atoi.s19 + 0)
.s18:
00:8c37 : e6 0e __ INC P1 ; (s + 1)
.s19:
00:8c39 : a5 43 __ LDA T0 + 0 
00:8c3b : 0a __ __ ASL
00:8c3c : 85 1b __ STA ACCU + 0 
00:8c3e : a5 44 __ LDA T0 + 1 
00:8c40 : 2a __ __ ROL
00:8c41 : 06 1b __ ASL ACCU + 0 
00:8c43 : 2a __ __ ROL
00:8c44 : aa __ __ TAX
00:8c45 : 18 __ __ CLC
00:8c46 : a5 1b __ LDA ACCU + 0 
00:8c48 : 65 43 __ ADC T0 + 0 
00:8c4a : 85 43 __ STA T0 + 0 
00:8c4c : 8a __ __ TXA
00:8c4d : 65 44 __ ADC T0 + 1 
00:8c4f : 06 43 __ ASL T0 + 0 
00:8c51 : 2a __ __ ROL
00:8c52 : aa __ __ TAX
00:8c53 : a5 1c __ LDA ACCU + 1 
00:8c55 : 84 1c __ STY ACCU + 1 
00:8c57 : 38 __ __ SEC
00:8c58 : e9 30 __ SBC #$30
00:8c5a : 18 __ __ CLC
00:8c5b : 65 43 __ ADC T0 + 0 
00:8c5d : 85 43 __ STA T0 + 0 
00:8c5f : 8a __ __ TXA
00:8c60 : 69 00 __ ADC #$00
00:8c62 : 4c 22 8c JMP $8c22 ; (atoi.l8 + 0)
.s9:
00:8c65 : a5 1d __ LDA ACCU + 2 
00:8c67 : d0 09 __ BNE $8c72 ; (atoi.s11 + 0)
.s10:
00:8c69 : a5 43 __ LDA T0 + 0 
00:8c6b : 85 1b __ STA ACCU + 0 
00:8c6d : a5 44 __ LDA T0 + 1 
00:8c6f : 4c f6 8b JMP $8bf6 ; (atoi.s3 + 0)
.s11:
00:8c72 : 38 __ __ SEC
00:8c73 : a9 00 __ LDA #$00
00:8c75 : e5 43 __ SBC T0 + 0 
00:8c77 : 85 1b __ STA ACCU + 0 
00:8c79 : a9 00 __ LDA #$00
00:8c7b : e5 44 __ SBC T0 + 1 
00:8c7d : 4c f6 8b JMP $8bf6 ; (atoi.s3 + 0)
--------------------------------------------------------------------
strchr@proxy: ; strchr@proxy
00:8c80 : a9 0a __ LDA #$0a
00:8c82 : 85 0d __ STA P0 
00:8c84 : a9 11 __ LDA #$11
00:8c86 : 85 0e __ STA P1 
00:8c88 : a9 7c __ LDA #$7c
00:8c8a : 85 0f __ STA P2 
00:8c8c : a9 00 __ LDA #$00
00:8c8e : 85 10 __ STA P3 
--------------------------------------------------------------------
strchr: ; strchr(const u8*,i16)->u8*
;  18, "/usr/local/include/oscar64/string.h"
.l4:
00:8c90 : a0 00 __ LDY #$00
00:8c92 : b1 0d __ LDA (P0),y ; (str + 0)
00:8c94 : c5 0f __ CMP P2 ; (ch + 0)
00:8c96 : d0 09 __ BNE $8ca1 ; (strchr.s6 + 0)
.s5:
00:8c98 : a5 0d __ LDA P0 ; (str + 0)
00:8c9a : 85 1b __ STA ACCU + 0 
00:8c9c : a5 0e __ LDA P1 ; (str + 1)
.s3:
00:8c9e : 85 1c __ STA ACCU + 1 
00:8ca0 : 60 __ __ RTS
.s6:
00:8ca1 : aa __ __ TAX
00:8ca2 : f0 09 __ BEQ $8cad ; (strchr.s7 + 0)
.s8:
00:8ca4 : e6 0d __ INC P0 ; (str + 0)
00:8ca6 : d0 e8 __ BNE $8c90 ; (strchr.l4 + 0)
.s9:
00:8ca8 : e6 0e __ INC P1 ; (str + 1)
00:8caa : 4c 90 8c JMP $8c90 ; (strchr.l4 + 0)
.s7:
00:8cad : 85 1b __ STA ACCU + 0 
00:8caf : 4c 9e 8c JMP $8c9e ; (strchr.s3 + 0)
--------------------------------------------------------------------
strncpy: ; strncpy(u8*,const u8*,i16)->void
;   6, "/usr/local/include/oscar64/string.h"
.s4:
00:8cb2 : a9 1e __ LDA #$1e
00:8cb4 : 85 1b __ STA ACCU + 0 
00:8cb6 : a2 00 __ LDX #$00
.l5:
00:8cb8 : a0 00 __ LDY #$00
00:8cba : b1 0f __ LDA (P2),y ; (src + 0)
00:8cbc : 91 0d __ STA (P0),y ; (dst + 0)
00:8cbe : e6 0d __ INC P0 ; (dst + 0)
00:8cc0 : d0 02 __ BNE $8cc4 ; (strncpy.s12 + 0)
.s11:
00:8cc2 : e6 0e __ INC P1 ; (dst + 1)
.s12:
00:8cc4 : 09 00 __ ORA #$00
00:8cc6 : f0 1a __ BEQ $8ce2 ; (strncpy.s6 + 0)
.s9:
00:8cc8 : e6 0f __ INC P2 ; (src + 0)
00:8cca : d0 02 __ BNE $8cce ; (strncpy.s14 + 0)
.s13:
00:8ccc : e6 10 __ INC P3 ; (src + 1)
.s14:
00:8cce : 8a __ __ TXA
00:8ccf : 05 1b __ ORA ACCU + 0 
00:8cd1 : 85 1c __ STA ACCU + 1 
00:8cd3 : 18 __ __ CLC
00:8cd4 : a5 1b __ LDA ACCU + 0 
00:8cd6 : 69 ff __ ADC #$ff
00:8cd8 : 85 1b __ STA ACCU + 0 
00:8cda : 8a __ __ TXA
00:8cdb : 69 ff __ ADC #$ff
00:8cdd : aa __ __ TAX
00:8cde : a5 1c __ LDA ACCU + 1 
00:8ce0 : d0 d6 __ BNE $8cb8 ; (strncpy.l5 + 0)
.s6:
00:8ce2 : 8a __ __ TXA
00:8ce3 : 30 17 __ BMI $8cfc ; (strncpy.s3 + 0)
.s8:
00:8ce5 : 05 1b __ ORA ACCU + 0 
00:8ce7 : f0 13 __ BEQ $8cfc ; (strncpy.s3 + 0)
.s7:
00:8ce9 : a5 0d __ LDA P0 ; (dst + 0)
00:8ceb : 84 0d __ STY P0 ; (dst + 0)
00:8ced : a8 __ __ TAY
00:8cee : a6 1b __ LDX ACCU + 0 
.l10:
00:8cf0 : a9 00 __ LDA #$00
00:8cf2 : 91 0d __ STA (P0),y ; (dst + 0)
00:8cf4 : c8 __ __ INY
00:8cf5 : d0 02 __ BNE $8cf9 ; (strncpy.s16 + 0)
.s15:
00:8cf7 : e6 0e __ INC P1 ; (dst + 1)
.s16:
00:8cf9 : ca __ __ DEX
00:8cfa : d0 f4 __ BNE $8cf0 ; (strncpy.l10 + 0)
.s3:
00:8cfc : 60 __ __ RTS
--------------------------------------------------------------------
draw_list: ; draw_list(const u8*)->void
; 462, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
00:8cfd : a2 05 __ LDX #$05
00:8cff : b5 53 __ LDA T2 + 0,x 
00:8d01 : 9d a8 46 STA $46a8,x ; (draw_list@stack + 0)
00:8d04 : ca __ __ DEX
00:8d05 : 10 f8 __ BPL $8cff ; (draw_list.s1 + 2)
.s4:
00:8d07 : a9 00 __ LDA #$00
00:8d09 : 85 0d __ STA P0 
00:8d0b : 85 0e __ STA P1 
00:8d0d : a9 07 __ LDA #$07
00:8d0f : 85 11 __ STA P4 
00:8d11 : 20 66 84 JSR $8466 ; (clear_screen.s4 + 0)
00:8d14 : ad fe 46 LDA $46fe ; (sstack + 8)
00:8d17 : 85 0f __ STA P2 
00:8d19 : ad ff 46 LDA $46ff ; (sstack + 9)
00:8d1c : 85 10 __ STA P3 
00:8d1e : 20 a9 8e JSR $8ea9 ; (print_at_color.s4 + 0)
00:8d21 : ad 62 a7 LDA $a762 ; (current_page + 0)
00:8d24 : 85 53 __ STA T2 + 0 
00:8d26 : ad 63 a7 LDA $a763 ; (current_page + 1)
00:8d29 : 85 54 __ STA T2 + 1 
00:8d2b : d0 3d __ BNE $8d6a ; (draw_list.s5 + 0)
.s26:
00:8d2d : a5 53 __ LDA T2 + 0 
00:8d2f : c9 02 __ CMP #$02
00:8d31 : d0 37 __ BNE $8d6a ; (draw_list.s5 + 0)
.s25:
00:8d33 : e6 0e __ INC P1 
00:8d35 : a9 f7 __ LDA #$f7
00:8d37 : 85 0f __ STA P2 
00:8d39 : a9 8a __ LDA #$8a
00:8d3b : 85 10 __ STA P3 
00:8d3d : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:8d40 : a9 08 __ LDA #$08
00:8d42 : 85 0d __ STA P0 
00:8d44 : a9 14 __ LDA #$14
00:8d46 : 85 10 __ STA P3 
00:8d48 : a9 34 __ LDA #$34
00:8d4a : 85 0f __ STA P2 
00:8d4c : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:8d4f : ad 64 a7 LDA $a764 ; (search_query_len + 0)
00:8d52 : 18 __ __ CLC
00:8d53 : 69 08 __ ADC #$08
00:8d55 : 85 0d __ STA P0 
00:8d57 : a9 fc __ LDA #$fc
00:8d59 : 85 0f __ STA P2 
00:8d5b : a9 89 __ LDA #$89
00:8d5d : 85 10 __ STA P3 
00:8d5f : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:8d62 : a9 02 __ LDA #$02
00:8d64 : 85 53 __ STA T2 + 0 
00:8d66 : a9 00 __ LDA #$00
00:8d68 : 85 54 __ STA T2 + 1 
.s5:
00:8d6a : ad 5a a7 LDA $a75a ; (item_count + 0)
00:8d6d : 85 55 __ STA T3 + 0 
00:8d6f : ad 5b a7 LDA $a75b ; (item_count + 1)
00:8d72 : 85 56 __ STA T3 + 1 
00:8d74 : 30 56 __ BMI $8dcc ; (draw_list.s6 + 0)
.s24:
00:8d76 : 05 55 __ ORA T3 + 0 
00:8d78 : f0 52 __ BEQ $8dcc ; (draw_list.s6 + 0)
.s23:
00:8d7a : ad 60 a7 LDA $a760 ; (offset + 0)
00:8d7d : 18 __ __ CLC
00:8d7e : 69 01 __ ADC #$01
00:8d80 : 8d f8 46 STA $46f8 ; (sstack + 2)
00:8d83 : a9 b0 __ LDA #$b0
00:8d85 : 85 16 __ STA P9 
00:8d87 : a9 46 __ LDA #$46
00:8d89 : 85 17 __ STA P10 
00:8d8b : a9 c0 __ LDA #$c0
00:8d8d : 8d f6 46 STA $46f6 ; (sstack + 0)
00:8d90 : a9 99 __ LDA #$99
00:8d92 : 8d f7 46 STA $46f7 ; (sstack + 1)
00:8d95 : ad 61 a7 LDA $a761 ; (offset + 1)
00:8d98 : 69 00 __ ADC #$00
00:8d9a : 8d f9 46 STA $46f9 ; (sstack + 3)
00:8d9d : 18 __ __ CLC
00:8d9e : a5 55 __ LDA T3 + 0 
00:8da0 : 6d 60 a7 ADC $a760 ; (offset + 0)
00:8da3 : 8d fa 46 STA $46fa ; (sstack + 4)
00:8da6 : a5 56 __ LDA T3 + 1 
00:8da8 : 6d 61 a7 ADC $a761 ; (offset + 1)
00:8dab : 8d fb 46 STA $46fb ; (sstack + 5)
00:8dae : ad 5c a7 LDA $a75c ; (total_count + 0)
00:8db1 : 8d fc 46 STA $46fc ; (sstack + 6)
00:8db4 : ad 5d a7 LDA $a75d ; (total_count + 1)
00:8db7 : 8d fd 46 STA $46fd ; (sstack + 7)
00:8dba : 20 2d 8f JSR $8f2d ; (sprintf.s1 + 0)
00:8dbd : a9 46 __ LDA #$46
00:8dbf : 85 10 __ STA P3 
00:8dc1 : a9 02 __ LDA #$02
00:8dc3 : 85 0e __ STA P1 
00:8dc5 : a9 b0 __ LDA #$b0
00:8dc7 : 85 0f __ STA P2 
00:8dc9 : 20 4d a7 JSR $a74d ; (print_at@proxy + 0)
.s6:
00:8dcc : a5 56 __ LDA T3 + 1 
00:8dce : 30 67 __ BMI $8e37 ; (draw_list.s7 + 0)
.s22:
00:8dd0 : 05 55 __ ORA T3 + 0 
00:8dd2 : f0 63 __ BEQ $8e37 ; (draw_list.s7 + 0)
.s14:
00:8dd4 : a9 00 __ LDA #$00
00:8dd6 : 85 43 __ STA T0 + 0 
00:8dd8 : 18 __ __ CLC
.l15:
00:8dd9 : 69 04 __ ADC #$04
00:8ddb : 85 0e __ STA P1 
00:8ddd : a5 43 __ LDA T0 + 0 
00:8ddf : 4a __ __ LSR
00:8de0 : 6a __ __ ROR
00:8de1 : 6a __ __ ROR
00:8de2 : aa __ __ TAX
00:8de3 : 29 c0 __ AND #$c0
00:8de5 : 6a __ __ ROR
00:8de6 : 69 8c __ ADC #$8c
00:8de8 : 85 57 __ STA T5 + 0 
00:8dea : 85 0f __ STA P2 
00:8dec : 8a __ __ TXA
00:8ded : 29 1f __ AND #$1f
00:8def : 69 11 __ ADC #$11
00:8df1 : 85 58 __ STA T5 + 1 
00:8df3 : 85 10 __ STA P3 
00:8df5 : ad 5f a7 LDA $a75f ; (cursor + 1)
00:8df8 : d0 07 __ BNE $8e01 ; (draw_list.s16 + 0)
.s21:
00:8dfa : a5 43 __ LDA T0 + 0 
00:8dfc : cd 5e a7 CMP $a75e ; (cursor + 0)
00:8dff : f0 0a __ BEQ $8e0b ; (draw_list.s20 + 0)
.s16:
00:8e01 : a9 02 __ LDA #$02
00:8e03 : 85 0d __ STA P0 
00:8e05 : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
00:8e08 : 4c 1d 8e JMP $8e1d ; (draw_list.s17 + 0)
.s20:
00:8e0b : 20 eb a6 JSR $a6eb ; (print_at_color@proxy + 0)
00:8e0e : a5 57 __ LDA T5 + 0 
00:8e10 : 85 0f __ STA P2 
00:8e12 : a9 02 __ LDA #$02
00:8e14 : 85 0d __ STA P0 
00:8e16 : a5 58 __ LDA T5 + 1 
00:8e18 : 85 10 __ STA P3 
00:8e1a : 20 a9 8e JSR $8ea9 ; (print_at_color.s4 + 0)
.s17:
00:8e1d : 18 __ __ CLC
00:8e1e : a5 0e __ LDA P1 
00:8e20 : 69 fd __ ADC #$fd
00:8e22 : 85 43 __ STA T0 + 0 
00:8e24 : a5 56 __ LDA T3 + 1 
00:8e26 : f0 05 __ BEQ $8e2d ; (draw_list.s19 + 0)
.s27:
00:8e28 : a5 43 __ LDA T0 + 0 
00:8e2a : 4c 33 8e JMP $8e33 ; (draw_list.s18 + 0)
.s19:
00:8e2d : a5 43 __ LDA T0 + 0 
00:8e2f : c5 55 __ CMP T3 + 0 
00:8e31 : b0 04 __ BCS $8e37 ; (draw_list.s7 + 0)
.s18:
00:8e33 : c9 12 __ CMP #$12
00:8e35 : 90 a2 __ BCC $8dd9 ; (draw_list.l15 + 0)
.s7:
00:8e37 : a9 00 __ LDA #$00
00:8e39 : 85 0d __ STA P0 
00:8e3b : a9 17 __ LDA #$17
00:8e3d : 85 0e __ STA P1 
00:8e3f : a5 53 __ LDA T2 + 0 
00:8e41 : 05 54 __ ORA T2 + 1 
00:8e43 : d0 16 __ BNE $8e5b ; (draw_list.s8 + 0)
.s13:
00:8e45 : a9 99 __ LDA #$99
00:8e47 : a0 cc __ LDY #$cc
.s10:
00:8e49 : 84 0f __ STY P2 
00:8e4b : 85 10 __ STA P3 
00:8e4d : 20 dc 84 JSR $84dc ; (print_at.s4 + 0)
.s3:
00:8e50 : a2 05 __ LDX #$05
00:8e52 : bd a8 46 LDA $46a8,x ; (draw_list@stack + 0)
00:8e55 : 95 53 __ STA T2 + 0,x 
00:8e57 : ca __ __ DEX
00:8e58 : 10 f8 __ BPL $8e52 ; (draw_list.s3 + 2)
00:8e5a : 60 __ __ RTS
.s8:
00:8e5b : a5 54 __ LDA T2 + 1 
00:8e5d : d0 05 __ BNE $8e64 ; (draw_list.s9 + 0)
.s12:
00:8e5f : a6 53 __ LDX T2 + 0 
00:8e61 : ca __ __ DEX
00:8e62 : f0 07 __ BEQ $8e6b ; (draw_list.s11 + 0)
.s9:
00:8e64 : a9 9a __ LDA #$9a
00:8e66 : a0 25 __ LDY #$25
00:8e68 : 4c 49 8e JMP $8e49 ; (draw_list.s10 + 0)
.s11:
00:8e6b : a9 9a __ LDA #$9a
00:8e6d : a0 00 __ LDY #$00
00:8e6f : 4c 49 8e JMP $8e49 ; (draw_list.s10 + 0)
--------------------------------------------------------------------
draw_item: ; draw_item(i16,bool)->void
; 438, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:8e72 : 18 __ __ CLC
00:8e73 : a5 14 __ LDA P7 ; (i + 0)
00:8e75 : 69 04 __ ADC #$04
00:8e77 : 85 13 __ STA P6 
00:8e79 : 20 14 88 JSR $8814 ; (clear_line.s4 + 0)
00:8e7c : a5 13 __ LDA P6 
00:8e7e : 85 0e __ STA P1 
00:8e80 : a5 16 __ LDA P9 ; (selected + 0)
00:8e82 : d0 06 __ BNE $8e8a ; (draw_item.s7 + 0)
.s5:
00:8e84 : a9 0e __ LDA #$0e
00:8e86 : 85 11 __ STA P4 
00:8e88 : d0 03 __ BNE $8e8d ; (draw_item.s6 + 0)
.s7:
00:8e8a : 20 eb a6 JSR $a6eb ; (print_at_color@proxy + 0)
.s6:
00:8e8d : a5 15 __ LDA P8 ; (i + 1)
00:8e8f : 4a __ __ LSR
00:8e90 : 66 14 __ ROR P7 ; (i + 0)
00:8e92 : 6a __ __ ROR
00:8e93 : 66 14 __ ROR P7 ; (i + 0)
00:8e95 : 6a __ __ ROR
00:8e96 : 66 14 __ ROR P7 ; (i + 0)
00:8e98 : 29 c0 __ AND #$c0
00:8e9a : 6a __ __ ROR
00:8e9b : 69 8c __ ADC #$8c
00:8e9d : 85 0f __ STA P2 
00:8e9f : a9 02 __ LDA #$02
00:8ea1 : 85 0d __ STA P0 
00:8ea3 : a9 11 __ LDA #$11
00:8ea5 : 65 14 __ ADC P7 ; (i + 0)
00:8ea7 : 85 10 __ STA P3 
--------------------------------------------------------------------
print_at_color: ; print_at_color(u8,u8,const u8*,u8)->void
;  80, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:8ea9 : a5 0e __ LDA P1 ; (y + 0)
00:8eab : 0a __ __ ASL
00:8eac : 85 1b __ STA ACCU + 0 
00:8eae : a9 00 __ LDA #$00
00:8eb0 : 2a __ __ ROL
00:8eb1 : 06 1b __ ASL ACCU + 0 
00:8eb3 : 2a __ __ ROL
00:8eb4 : aa __ __ TAX
00:8eb5 : a5 1b __ LDA ACCU + 0 
00:8eb7 : 65 0e __ ADC P1 ; (y + 0)
00:8eb9 : 85 43 __ STA T1 + 0 
00:8ebb : 8a __ __ TXA
00:8ebc : 69 00 __ ADC #$00
00:8ebe : 06 43 __ ASL T1 + 0 
00:8ec0 : 2a __ __ ROL
00:8ec1 : 06 43 __ ASL T1 + 0 
00:8ec3 : 2a __ __ ROL
00:8ec4 : 06 43 __ ASL T1 + 0 
00:8ec6 : 2a __ __ ROL
00:8ec7 : aa __ __ TAX
00:8ec8 : a5 43 __ LDA T1 + 0 
00:8eca : 65 0d __ ADC P0 ; (x + 0)
00:8ecc : 85 45 __ STA T2 + 0 
00:8ece : 85 43 __ STA T1 + 0 
00:8ed0 : 8a __ __ TXA
00:8ed1 : 69 04 __ ADC #$04
00:8ed3 : 85 46 __ STA T2 + 1 
00:8ed5 : 69 d4 __ ADC #$d4
00:8ed7 : 85 44 __ STA T1 + 1 
00:8ed9 : a0 00 __ LDY #$00
00:8edb : b1 0f __ LDA (P2),y ; (text + 0)
00:8edd : f0 4d __ BEQ $8f2c ; (print_at_color.s3 + 0)
.s14:
00:8edf : a6 0f __ LDX P2 ; (text + 0)
.l5:
00:8ee1 : 86 1b __ STX ACCU + 0 
00:8ee3 : 8a __ __ TXA
00:8ee4 : 18 __ __ CLC
00:8ee5 : 69 01 __ ADC #$01
00:8ee7 : aa __ __ TAX
00:8ee8 : a5 10 __ LDA P3 ; (text + 1)
00:8eea : 85 1c __ STA ACCU + 1 
00:8eec : 69 00 __ ADC #$00
00:8eee : 85 10 __ STA P3 ; (text + 1)
00:8ef0 : a0 00 __ LDY #$00
00:8ef2 : b1 1b __ LDA (ACCU + 0),y 
00:8ef4 : c9 61 __ CMP #$61
00:8ef6 : 90 09 __ BCC $8f01 ; (print_at_color.s6 + 0)
.s11:
00:8ef8 : c9 7b __ CMP #$7b
00:8efa : b0 05 __ BCS $8f01 ; (print_at_color.s6 + 0)
.s12:
00:8efc : 69 a0 __ ADC #$a0
00:8efe : 4c 14 8f JMP $8f14 ; (print_at_color.s13 + 0)
.s6:
00:8f01 : c9 41 __ CMP #$41
00:8f03 : 90 0f __ BCC $8f14 ; (print_at_color.s13 + 0)
.s7:
00:8f05 : c9 5b __ CMP #$5b
00:8f07 : b0 05 __ BCS $8f0e ; (print_at_color.s8 + 0)
.s10:
00:8f09 : 69 c0 __ ADC #$c0
00:8f0b : 4c 14 8f JMP $8f14 ; (print_at_color.s13 + 0)
.s8:
00:8f0e : c9 7c __ CMP #$7c
00:8f10 : d0 02 __ BNE $8f14 ; (print_at_color.s13 + 0)
.s9:
00:8f12 : a9 20 __ LDA #$20
.s13:
00:8f14 : 91 45 __ STA (T2 + 0),y 
00:8f16 : a5 11 __ LDA P4 ; (color + 0)
00:8f18 : 91 43 __ STA (T1 + 0),y 
00:8f1a : e6 45 __ INC T2 + 0 
00:8f1c : d0 02 __ BNE $8f20 ; (print_at_color.s16 + 0)
.s15:
00:8f1e : e6 46 __ INC T2 + 1 
.s16:
00:8f20 : e6 43 __ INC T1 + 0 
00:8f22 : d0 02 __ BNE $8f26 ; (print_at_color.s18 + 0)
.s17:
00:8f24 : e6 44 __ INC T1 + 1 
.s18:
00:8f26 : a0 01 __ LDY #$01
00:8f28 : b1 1b __ LDA (ACCU + 0),y 
00:8f2a : d0 b5 __ BNE $8ee1 ; (print_at_color.l5 + 0)
.s3:
00:8f2c : 60 __ __ RTS
--------------------------------------------------------------------
sprintf: ; sprintf(u8*,const u8*)->void
;  20, "/usr/local/include/oscar64/stdio.h"
.s1:
00:8f2d : a2 03 __ LDX #$03
00:8f2f : b5 53 __ LDA T3 + 0,x 
00:8f31 : 9d d8 46 STA $46d8,x ; (sprintf@stack + 0)
00:8f34 : ca __ __ DEX
00:8f35 : 10 f8 __ BPL $8f2f ; (sprintf.s1 + 2)
.s4:
00:8f37 : ad f6 46 LDA $46f6 ; (sstack + 0)
00:8f3a : 85 55 __ STA T4 + 0 
00:8f3c : a9 f8 __ LDA #$f8
00:8f3e : 85 53 __ STA T3 + 0 
00:8f40 : a9 46 __ LDA #$46
00:8f42 : 85 54 __ STA T3 + 1 
00:8f44 : a9 00 __ LDA #$00
00:8f46 : 85 49 __ STA T2 + 0 
00:8f48 : ad f7 46 LDA $46f7 ; (sstack + 1)
00:8f4b : 85 56 __ STA T4 + 1 
.l5:
00:8f4d : a0 00 __ LDY #$00
00:8f4f : b1 55 __ LDA (T4 + 0),y 
00:8f51 : d0 0f __ BNE $8f62 ; (sprintf.s7 + 0)
.s6:
00:8f53 : a4 49 __ LDY T2 + 0 
00:8f55 : 91 16 __ STA (P9),y ; (str + 0)
.s3:
00:8f57 : a2 03 __ LDX #$03
00:8f59 : bd d8 46 LDA $46d8,x ; (sprintf@stack + 0)
00:8f5c : 95 53 __ STA T3 + 0,x 
00:8f5e : ca __ __ DEX
00:8f5f : 10 f8 __ BPL $8f59 ; (sprintf.s3 + 2)
00:8f61 : 60 __ __ RTS
.s7:
00:8f62 : c9 25 __ CMP #$25
00:8f64 : f0 22 __ BEQ $8f88 ; (sprintf.s10 + 0)
.s8:
00:8f66 : a4 49 __ LDY T2 + 0 
00:8f68 : 91 16 __ STA (P9),y ; (str + 0)
00:8f6a : e6 55 __ INC T4 + 0 
00:8f6c : d0 02 __ BNE $8f70 ; (sprintf.s114 + 0)
.s113:
00:8f6e : e6 56 __ INC T4 + 1 
.s114:
00:8f70 : c8 __ __ INY
00:8f71 : 84 49 __ STY T2 + 0 
00:8f73 : 98 __ __ TYA
00:8f74 : c0 28 __ CPY #$28
00:8f76 : 90 d5 __ BCC $8f4d ; (sprintf.l5 + 0)
.s9:
00:8f78 : 18 __ __ CLC
00:8f79 : 65 16 __ ADC P9 ; (str + 0)
00:8f7b : 85 16 __ STA P9 ; (str + 0)
00:8f7d : 90 02 __ BCC $8f81 ; (sprintf.s116 + 0)
.s115:
00:8f7f : e6 17 __ INC P10 ; (str + 1)
.s116:
00:8f81 : a9 00 __ LDA #$00
.s87:
00:8f83 : 85 49 __ STA T2 + 0 
00:8f85 : 4c 4d 8f JMP $8f4d ; (sprintf.l5 + 0)
.s10:
00:8f88 : 8c e5 46 STY $46e5 ; (si.prefix + 0)
00:8f8b : a5 49 __ LDA T2 + 0 
00:8f8d : f0 0c __ BEQ $8f9b ; (sprintf.s11 + 0)
.s82:
00:8f8f : 84 49 __ STY T2 + 0 
00:8f91 : 18 __ __ CLC
00:8f92 : 65 16 __ ADC P9 ; (str + 0)
00:8f94 : 85 16 __ STA P9 ; (str + 0)
00:8f96 : 90 02 __ BCC $8f9a ; (sprintf.s95 + 0)
.s94:
00:8f98 : e6 17 __ INC P10 ; (str + 1)
.s95:
00:8f9a : 98 __ __ TYA
.s11:
00:8f9b : 8d e3 46 STA $46e3 ; (si.sign + 0)
00:8f9e : 8d e4 46 STA $46e4 ; (si.left + 0)
00:8fa1 : a0 01 __ LDY #$01
00:8fa3 : b1 55 __ LDA (T4 + 0),y 
00:8fa5 : a2 20 __ LDX #$20
00:8fa7 : 8e de 46 STX $46de ; (si.fill + 0)
00:8faa : a2 00 __ LDX #$00
00:8fac : 8e df 46 STX $46df ; (si.width + 0)
00:8faf : ca __ __ DEX
00:8fb0 : 8e e0 46 STX $46e0 ; (si.precision + 0)
00:8fb3 : a2 0a __ LDX #$0a
00:8fb5 : 8e e2 46 STX $46e2 ; (si.base + 0)
00:8fb8 : aa __ __ TAX
00:8fb9 : a9 02 __ LDA #$02
00:8fbb : d0 07 __ BNE $8fc4 ; (sprintf.l12 + 0)
.s78:
00:8fbd : a0 00 __ LDY #$00
00:8fbf : b1 55 __ LDA (T4 + 0),y 
00:8fc1 : aa __ __ TAX
00:8fc2 : a9 01 __ LDA #$01
.l12:
00:8fc4 : 18 __ __ CLC
00:8fc5 : 65 55 __ ADC T4 + 0 
00:8fc7 : 85 55 __ STA T4 + 0 
00:8fc9 : 90 02 __ BCC $8fcd ; (sprintf.s97 + 0)
.s96:
00:8fcb : e6 56 __ INC T4 + 1 
.s97:
00:8fcd : 8a __ __ TXA
00:8fce : e0 2b __ CPX #$2b
00:8fd0 : d0 07 __ BNE $8fd9 ; (sprintf.s13 + 0)
.s81:
00:8fd2 : a9 01 __ LDA #$01
00:8fd4 : 8d e3 46 STA $46e3 ; (si.sign + 0)
00:8fd7 : d0 e4 __ BNE $8fbd ; (sprintf.s78 + 0)
.s13:
00:8fd9 : c9 30 __ CMP #$30
00:8fdb : d0 06 __ BNE $8fe3 ; (sprintf.s14 + 0)
.s80:
00:8fdd : 8d de 46 STA $46de ; (si.fill + 0)
00:8fe0 : 4c bd 8f JMP $8fbd ; (sprintf.s78 + 0)
.s14:
00:8fe3 : c9 23 __ CMP #$23
00:8fe5 : d0 07 __ BNE $8fee ; (sprintf.s15 + 0)
.s79:
00:8fe7 : a9 01 __ LDA #$01
00:8fe9 : 8d e5 46 STA $46e5 ; (si.prefix + 0)
00:8fec : d0 cf __ BNE $8fbd ; (sprintf.s78 + 0)
.s15:
00:8fee : c9 2d __ CMP #$2d
00:8ff0 : d0 07 __ BNE $8ff9 ; (sprintf.s16 + 0)
.s77:
00:8ff2 : a9 01 __ LDA #$01
00:8ff4 : 8d e4 46 STA $46e4 ; (si.left + 0)
00:8ff7 : d0 c4 __ BNE $8fbd ; (sprintf.s78 + 0)
.s16:
00:8ff9 : 85 4b __ STA T6 + 0 
00:8ffb : c9 30 __ CMP #$30
00:8ffd : 90 31 __ BCC $9030 ; (sprintf.s17 + 0)
.s72:
00:8fff : c9 3a __ CMP #$3a
00:9001 : b0 5e __ BCS $9061 ; (sprintf.s18 + 0)
.s73:
00:9003 : a9 00 __ LDA #$00
00:9005 : 85 47 __ STA T1 + 0 
.l74:
00:9007 : a5 47 __ LDA T1 + 0 
00:9009 : 0a __ __ ASL
00:900a : 0a __ __ ASL
00:900b : 18 __ __ CLC
00:900c : 65 47 __ ADC T1 + 0 
00:900e : 0a __ __ ASL
00:900f : 18 __ __ CLC
00:9010 : 65 4b __ ADC T6 + 0 
00:9012 : 38 __ __ SEC
00:9013 : e9 30 __ SBC #$30
00:9015 : 85 47 __ STA T1 + 0 
00:9017 : a0 00 __ LDY #$00
00:9019 : b1 55 __ LDA (T4 + 0),y 
00:901b : 85 4b __ STA T6 + 0 
00:901d : e6 55 __ INC T4 + 0 
00:901f : d0 02 __ BNE $9023 ; (sprintf.s112 + 0)
.s111:
00:9021 : e6 56 __ INC T4 + 1 
.s112:
00:9023 : c9 30 __ CMP #$30
00:9025 : 90 04 __ BCC $902b ; (sprintf.s75 + 0)
.s76:
00:9027 : c9 3a __ CMP #$3a
00:9029 : 90 dc __ BCC $9007 ; (sprintf.l74 + 0)
.s75:
00:902b : a6 47 __ LDX T1 + 0 
00:902d : 8e df 46 STX $46df ; (si.width + 0)
.s17:
00:9030 : c9 2e __ CMP #$2e
00:9032 : d0 2d __ BNE $9061 ; (sprintf.s18 + 0)
.s67:
00:9034 : a9 00 __ LDA #$00
00:9036 : f0 0e __ BEQ $9046 ; (sprintf.l68 + 0)
.s71:
00:9038 : a5 43 __ LDA T0 + 0 
00:903a : 0a __ __ ASL
00:903b : 0a __ __ ASL
00:903c : 18 __ __ CLC
00:903d : 65 43 __ ADC T0 + 0 
00:903f : 0a __ __ ASL
00:9040 : 18 __ __ CLC
00:9041 : 65 4b __ ADC T6 + 0 
00:9043 : 38 __ __ SEC
00:9044 : e9 30 __ SBC #$30
.l68:
00:9046 : 85 43 __ STA T0 + 0 
00:9048 : a0 00 __ LDY #$00
00:904a : b1 55 __ LDA (T4 + 0),y 
00:904c : 85 4b __ STA T6 + 0 
00:904e : e6 55 __ INC T4 + 0 
00:9050 : d0 02 __ BNE $9054 ; (sprintf.s99 + 0)
.s98:
00:9052 : e6 56 __ INC T4 + 1 
.s99:
00:9054 : c9 30 __ CMP #$30
00:9056 : 90 04 __ BCC $905c ; (sprintf.s69 + 0)
.s70:
00:9058 : c9 3a __ CMP #$3a
00:905a : 90 dc __ BCC $9038 ; (sprintf.s71 + 0)
.s69:
00:905c : a6 43 __ LDX T0 + 0 
00:905e : 8e e0 46 STX $46e0 ; (si.precision + 0)
.s18:
00:9061 : c9 64 __ CMP #$64
00:9063 : f0 0c __ BEQ $9071 ; (sprintf.s66 + 0)
.s19:
00:9065 : c9 44 __ CMP #$44
00:9067 : f0 08 __ BEQ $9071 ; (sprintf.s66 + 0)
.s20:
00:9069 : c9 69 __ CMP #$69
00:906b : f0 04 __ BEQ $9071 ; (sprintf.s66 + 0)
.s21:
00:906d : c9 49 __ CMP #$49
00:906f : d0 11 __ BNE $9082 ; (sprintf.s22 + 0)
.s66:
00:9071 : a0 00 __ LDY #$00
00:9073 : b1 53 __ LDA (T3 + 0),y 
00:9075 : 85 11 __ STA P4 
00:9077 : c8 __ __ INY
00:9078 : b1 53 __ LDA (T3 + 0),y 
00:907a : 85 12 __ STA P5 
00:907c : 98 __ __ TYA
.s85:
00:907d : 85 13 __ STA P6 
00:907f : 4c 68 92 JMP $9268 ; (sprintf.s64 + 0)
.s22:
00:9082 : c9 75 __ CMP #$75
00:9084 : f0 04 __ BEQ $908a ; (sprintf.s65 + 0)
.s23:
00:9086 : c9 55 __ CMP #$55
00:9088 : d0 0f __ BNE $9099 ; (sprintf.s24 + 0)
.s65:
00:908a : a0 00 __ LDY #$00
00:908c : b1 53 __ LDA (T3 + 0),y 
00:908e : 85 11 __ STA P4 
00:9090 : c8 __ __ INY
00:9091 : b1 53 __ LDA (T3 + 0),y 
00:9093 : 85 12 __ STA P5 
00:9095 : a9 00 __ LDA #$00
00:9097 : f0 e4 __ BEQ $907d ; (sprintf.s85 + 0)
.s24:
00:9099 : c9 78 __ CMP #$78
00:909b : f0 04 __ BEQ $90a1 ; (sprintf.s63 + 0)
.s25:
00:909d : c9 58 __ CMP #$58
00:909f : d0 1e __ BNE $90bf ; (sprintf.s26 + 0)
.s63:
00:90a1 : a0 00 __ LDY #$00
00:90a3 : 84 13 __ STY P6 
00:90a5 : a9 10 __ LDA #$10
00:90a7 : 8d e2 46 STA $46e2 ; (si.base + 0)
00:90aa : b1 53 __ LDA (T3 + 0),y 
00:90ac : 85 11 __ STA P4 
00:90ae : c8 __ __ INY
00:90af : b1 53 __ LDA (T3 + 0),y 
00:90b1 : 85 12 __ STA P5 
00:90b3 : a5 4b __ LDA T6 + 0 
00:90b5 : 29 e0 __ AND #$e0
00:90b7 : 09 01 __ ORA #$01
00:90b9 : 8d e1 46 STA $46e1 ; (si.cha + 0)
00:90bc : 4c 68 92 JMP $9268 ; (sprintf.s64 + 0)
.s26:
00:90bf : c9 6c __ CMP #$6c
00:90c1 : d0 03 __ BNE $90c6 ; (sprintf.s27 + 0)
00:90c3 : 4c ed 91 JMP $91ed ; (sprintf.s51 + 0)
.s27:
00:90c6 : c9 4c __ CMP #$4c
00:90c8 : f0 f9 __ BEQ $90c3 ; (sprintf.s26 + 4)
.s28:
00:90ca : c9 66 __ CMP #$66
00:90cc : f0 14 __ BEQ $90e2 ; (sprintf.s50 + 0)
.s29:
00:90ce : c9 67 __ CMP #$67
00:90d0 : f0 10 __ BEQ $90e2 ; (sprintf.s50 + 0)
.s30:
00:90d2 : c9 65 __ CMP #$65
00:90d4 : f0 0c __ BEQ $90e2 ; (sprintf.s50 + 0)
.s31:
00:90d6 : c9 46 __ CMP #$46
00:90d8 : f0 08 __ BEQ $90e2 ; (sprintf.s50 + 0)
.s32:
00:90da : c9 47 __ CMP #$47
00:90dc : f0 04 __ BEQ $90e2 ; (sprintf.s50 + 0)
.s33:
00:90de : c9 45 __ CMP #$45
00:90e0 : d0 44 __ BNE $9126 ; (sprintf.s34 + 0)
.s50:
00:90e2 : a5 16 __ LDA P9 ; (str + 0)
00:90e4 : 85 0f __ STA P2 
00:90e6 : a5 17 __ LDA P10 ; (str + 1)
00:90e8 : 85 10 __ STA P3 
00:90ea : a0 00 __ LDY #$00
00:90ec : b1 53 __ LDA (T3 + 0),y 
00:90ee : 85 11 __ STA P4 
00:90f0 : c8 __ __ INY
00:90f1 : b1 53 __ LDA (T3 + 0),y 
00:90f3 : 85 12 __ STA P5 
00:90f5 : c8 __ __ INY
00:90f6 : b1 53 __ LDA (T3 + 0),y 
00:90f8 : 85 13 __ STA P6 
00:90fa : c8 __ __ INY
00:90fb : b1 53 __ LDA (T3 + 0),y 
00:90fd : 85 14 __ STA P7 
00:90ff : a5 4b __ LDA T6 + 0 
00:9101 : 29 e0 __ AND #$e0
00:9103 : 09 01 __ ORA #$01
00:9105 : 8d e1 46 STA $46e1 ; (si.cha + 0)
00:9108 : a9 de __ LDA #$de
00:910a : 85 0d __ STA P0 
00:910c : a9 46 __ LDA #$46
00:910e : 85 0e __ STA P1 
00:9110 : a5 4b __ LDA T6 + 0 
00:9112 : ed e1 46 SBC $46e1 ; (si.cha + 0)
00:9115 : 18 __ __ CLC
00:9116 : 69 61 __ ADC #$61
00:9118 : 85 15 __ STA P8 
00:911a : 20 e7 94 JSR $94e7 ; (nformf.s1 + 0)
00:911d : a5 1b __ LDA ACCU + 0 ; (fmt + 2)
00:911f : 85 49 __ STA T2 + 0 
00:9121 : a9 04 __ LDA #$04
00:9123 : 4c e1 91 JMP $91e1 ; (sprintf.s84 + 0)
.s34:
00:9126 : c9 73 __ CMP #$73
00:9128 : f0 2d __ BEQ $9157 ; (sprintf.s42 + 0)
.s35:
00:912a : c9 53 __ CMP #$53
00:912c : f0 29 __ BEQ $9157 ; (sprintf.s42 + 0)
.s36:
00:912e : c9 63 __ CMP #$63
00:9130 : f0 13 __ BEQ $9145 ; (sprintf.s41 + 0)
.s37:
00:9132 : c9 43 __ CMP #$43
00:9134 : f0 0f __ BEQ $9145 ; (sprintf.s41 + 0)
.s38:
00:9136 : aa __ __ TAX
00:9137 : d0 03 __ BNE $913c ; (sprintf.s39 + 0)
00:9139 : 4c 4d 8f JMP $8f4d ; (sprintf.l5 + 0)
.s39:
00:913c : a0 00 __ LDY #$00
00:913e : 91 16 __ STA (P9),y ; (str + 0)
.s40:
00:9140 : a9 01 __ LDA #$01
00:9142 : 4c 83 8f JMP $8f83 ; (sprintf.s87 + 0)
.s41:
00:9145 : a0 00 __ LDY #$00
00:9147 : b1 53 __ LDA (T3 + 0),y 
00:9149 : 91 16 __ STA (P9),y ; (str + 0)
00:914b : a5 53 __ LDA T3 + 0 
00:914d : 69 01 __ ADC #$01
00:914f : 85 53 __ STA T3 + 0 
00:9151 : 90 ed __ BCC $9140 ; (sprintf.s40 + 0)
.s110:
00:9153 : e6 54 __ INC T3 + 1 
00:9155 : b0 e9 __ BCS $9140 ; (sprintf.s40 + 0)
.s42:
00:9157 : a0 00 __ LDY #$00
00:9159 : 84 4b __ STY T6 + 0 
00:915b : b1 53 __ LDA (T3 + 0),y 
00:915d : 85 43 __ STA T0 + 0 
00:915f : c8 __ __ INY
00:9160 : b1 53 __ LDA (T3 + 0),y 
00:9162 : 85 44 __ STA T0 + 1 
00:9164 : a5 53 __ LDA T3 + 0 
00:9166 : 69 01 __ ADC #$01
00:9168 : 85 53 __ STA T3 + 0 
00:916a : 90 02 __ BCC $916e ; (sprintf.s106 + 0)
.s105:
00:916c : e6 54 __ INC T3 + 1 
.s106:
00:916e : ad df 46 LDA $46df ; (si.width + 0)
00:9171 : f0 0d __ BEQ $9180 ; (sprintf.s43 + 0)
.s91:
00:9173 : a0 00 __ LDY #$00
00:9175 : b1 43 __ LDA (T0 + 0),y 
00:9177 : f0 05 __ BEQ $917e ; (sprintf.s92 + 0)
.l49:
00:9179 : c8 __ __ INY
00:917a : b1 43 __ LDA (T0 + 0),y 
00:917c : d0 fb __ BNE $9179 ; (sprintf.l49 + 0)
.s92:
00:917e : 84 4b __ STY T6 + 0 
.s43:
00:9180 : ad e4 46 LDA $46e4 ; (si.left + 0)
00:9183 : 85 4d __ STA T8 + 0 
00:9185 : d0 19 __ BNE $91a0 ; (sprintf.s44 + 0)
.s89:
00:9187 : a6 4b __ LDX T6 + 0 
00:9189 : ec df 46 CPX $46df ; (si.width + 0)
00:918c : a0 00 __ LDY #$00
00:918e : b0 0c __ BCS $919c ; (sprintf.s90 + 0)
.l48:
00:9190 : ad de 46 LDA $46de ; (si.fill + 0)
00:9193 : 91 16 __ STA (P9),y ; (str + 0)
00:9195 : c8 __ __ INY
00:9196 : e8 __ __ INX
00:9197 : ec df 46 CPX $46df ; (si.width + 0)
00:919a : 90 f4 __ BCC $9190 ; (sprintf.l48 + 0)
.s90:
00:919c : 86 4b __ STX T6 + 0 
00:919e : 84 49 __ STY T2 + 0 
.s44:
00:91a0 : a0 00 __ LDY #$00
00:91a2 : b1 43 __ LDA (T0 + 0),y 
00:91a4 : f0 1a __ BEQ $91c0 ; (sprintf.s45 + 0)
.s47:
00:91a6 : e6 43 __ INC T0 + 0 
00:91a8 : d0 02 __ BNE $91ac ; (sprintf.l83 + 0)
.s107:
00:91aa : e6 44 __ INC T0 + 1 
.l83:
00:91ac : a4 49 __ LDY T2 + 0 
00:91ae : 91 16 __ STA (P9),y ; (str + 0)
00:91b0 : e6 49 __ INC T2 + 0 
00:91b2 : a0 00 __ LDY #$00
00:91b4 : b1 43 __ LDA (T0 + 0),y 
00:91b6 : a8 __ __ TAY
00:91b7 : e6 43 __ INC T0 + 0 
00:91b9 : d0 02 __ BNE $91bd ; (sprintf.s109 + 0)
.s108:
00:91bb : e6 44 __ INC T0 + 1 
.s109:
00:91bd : 98 __ __ TYA
00:91be : d0 ec __ BNE $91ac ; (sprintf.l83 + 0)
.s45:
00:91c0 : a5 4d __ LDA T8 + 0 
00:91c2 : d0 03 __ BNE $91c7 ; (sprintf.s88 + 0)
00:91c4 : 4c 4d 8f JMP $8f4d ; (sprintf.l5 + 0)
.s88:
00:91c7 : a6 4b __ LDX T6 + 0 
00:91c9 : ec df 46 CPX $46df ; (si.width + 0)
00:91cc : a4 49 __ LDY T2 + 0 
00:91ce : b0 0c __ BCS $91dc ; (sprintf.s93 + 0)
.l46:
00:91d0 : ad de 46 LDA $46de ; (si.fill + 0)
00:91d3 : 91 16 __ STA (P9),y ; (str + 0)
00:91d5 : c8 __ __ INY
00:91d6 : e8 __ __ INX
00:91d7 : ec df 46 CPX $46df ; (si.width + 0)
00:91da : 90 f4 __ BCC $91d0 ; (sprintf.l46 + 0)
.s93:
00:91dc : 84 49 __ STY T2 + 0 
00:91de : 4c 4d 8f JMP $8f4d ; (sprintf.l5 + 0)
.s84:
00:91e1 : 18 __ __ CLC
00:91e2 : 65 53 __ ADC T3 + 0 
00:91e4 : 85 53 __ STA T3 + 0 
00:91e6 : 90 f6 __ BCC $91de ; (sprintf.s93 + 2)
.s100:
00:91e8 : e6 54 __ INC T3 + 1 
00:91ea : 4c 4d 8f JMP $8f4d ; (sprintf.l5 + 0)
.s51:
00:91ed : a0 00 __ LDY #$00
00:91ef : b1 53 __ LDA (T3 + 0),y 
00:91f1 : 85 11 __ STA P4 
00:91f3 : c8 __ __ INY
00:91f4 : b1 53 __ LDA (T3 + 0),y 
00:91f6 : 85 12 __ STA P5 
00:91f8 : c8 __ __ INY
00:91f9 : b1 53 __ LDA (T3 + 0),y 
00:91fb : 85 13 __ STA P6 
00:91fd : c8 __ __ INY
00:91fe : b1 53 __ LDA (T3 + 0),y 
00:9200 : 85 14 __ STA P7 
00:9202 : a5 53 __ LDA T3 + 0 
00:9204 : 69 03 __ ADC #$03
00:9206 : 85 53 __ STA T3 + 0 
00:9208 : 90 02 __ BCC $920c ; (sprintf.s102 + 0)
.s101:
00:920a : e6 54 __ INC T3 + 1 
.s102:
00:920c : a0 00 __ LDY #$00
00:920e : b1 55 __ LDA (T4 + 0),y 
00:9210 : aa __ __ TAX
00:9211 : e6 55 __ INC T4 + 0 
00:9213 : d0 02 __ BNE $9217 ; (sprintf.s104 + 0)
.s103:
00:9215 : e6 56 __ INC T4 + 1 
.s104:
00:9217 : e0 64 __ CPX #$64
00:9219 : f0 0c __ BEQ $9227 ; (sprintf.s62 + 0)
.s52:
00:921b : e0 44 __ CPX #$44
00:921d : f0 08 __ BEQ $9227 ; (sprintf.s62 + 0)
.s53:
00:921f : e0 69 __ CPX #$69
00:9221 : f0 04 __ BEQ $9227 ; (sprintf.s62 + 0)
.s54:
00:9223 : e0 49 __ CPX #$49
00:9225 : d0 1c __ BNE $9243 ; (sprintf.s55 + 0)
.s62:
00:9227 : a9 01 __ LDA #$01
.s86:
00:9229 : 85 15 __ STA P8 
.s60:
00:922b : a5 16 __ LDA P9 ; (str + 0)
00:922d : 85 0f __ STA P2 
00:922f : a5 17 __ LDA P10 ; (str + 1)
00:9231 : 85 10 __ STA P3 
00:9233 : a9 de __ LDA #$de
00:9235 : 85 0d __ STA P0 
00:9237 : a9 46 __ LDA #$46
00:9239 : 85 0e __ STA P1 
00:923b : 20 9d 93 JSR $939d ; (nforml.s4 + 0)
00:923e : a5 1b __ LDA ACCU + 0 ; (fmt + 2)
00:9240 : 4c 83 8f JMP $8f83 ; (sprintf.s87 + 0)
.s55:
00:9243 : e0 75 __ CPX #$75
00:9245 : f0 04 __ BEQ $924b ; (sprintf.s61 + 0)
.s56:
00:9247 : e0 55 __ CPX #$55
00:9249 : d0 03 __ BNE $924e ; (sprintf.s57 + 0)
.s61:
00:924b : 98 __ __ TYA
00:924c : f0 db __ BEQ $9229 ; (sprintf.s86 + 0)
.s57:
00:924e : e0 78 __ CPX #$78
00:9250 : f0 04 __ BEQ $9256 ; (sprintf.s59 + 0)
.s58:
00:9252 : e0 58 __ CPX #$58
00:9254 : d0 94 __ BNE $91ea ; (sprintf.s100 + 2)
.s59:
00:9256 : 84 15 __ STY P8 
00:9258 : a9 10 __ LDA #$10
00:925a : 8d e2 46 STA $46e2 ; (si.base + 0)
00:925d : 8a __ __ TXA
00:925e : 29 e0 __ AND #$e0
00:9260 : 09 01 __ ORA #$01
00:9262 : 8d e1 46 STA $46e1 ; (si.cha + 0)
00:9265 : 4c 2b 92 JMP $922b ; (sprintf.s60 + 0)
.s64:
00:9268 : a5 16 __ LDA P9 ; (str + 0)
00:926a : 85 0f __ STA P2 
00:926c : a5 17 __ LDA P10 ; (str + 1)
00:926e : 85 10 __ STA P3 
00:9270 : a9 de __ LDA #$de
00:9272 : 85 0d __ STA P0 
00:9274 : a9 46 __ LDA #$46
00:9276 : 85 0e __ STA P1 
00:9278 : 20 82 92 JSR $9282 ; (nformi.s4 + 0)
00:927b : 85 49 __ STA T2 + 0 
00:927d : a9 02 __ LDA #$02
00:927f : 4c e1 91 JMP $91e1 ; (sprintf.s84 + 0)
--------------------------------------------------------------------
nformi: ; nformi(const struct sinfo*,u8*,i16,bool)->u8
;  79, "/usr/local/include/oscar64/stdio.c"
.s4:
00:9282 : a9 00 __ LDA #$00
00:9284 : 85 43 __ STA T5 + 0 
00:9286 : a0 04 __ LDY #$04
00:9288 : b1 0d __ LDA (P0),y ; (si + 0)
00:928a : 85 44 __ STA T6 + 0 
00:928c : a5 13 __ LDA P6 ; (s + 0)
00:928e : f0 13 __ BEQ $92a3 ; (nformi.s5 + 0)
.s33:
00:9290 : 24 12 __ BIT P5 ; (v + 1)
00:9292 : 10 0f __ BPL $92a3 ; (nformi.s5 + 0)
.s34:
00:9294 : 38 __ __ SEC
00:9295 : a9 00 __ LDA #$00
00:9297 : e5 11 __ SBC P4 ; (v + 0)
00:9299 : 85 11 __ STA P4 ; (v + 0)
00:929b : a9 00 __ LDA #$00
00:929d : e5 12 __ SBC P5 ; (v + 1)
00:929f : 85 12 __ STA P5 ; (v + 1)
00:92a1 : e6 43 __ INC T5 + 0 
.s5:
00:92a3 : a9 10 __ LDA #$10
00:92a5 : 85 45 __ STA T7 + 0 
00:92a7 : a5 11 __ LDA P4 ; (v + 0)
00:92a9 : 05 12 __ ORA P5 ; (v + 1)
00:92ab : f0 33 __ BEQ $92e0 ; (nformi.s6 + 0)
.s28:
00:92ad : a5 11 __ LDA P4 ; (v + 0)
00:92af : 85 1b __ STA ACCU + 0 
00:92b1 : a5 12 __ LDA P5 ; (v + 1)
00:92b3 : 85 1c __ STA ACCU + 1 
.l29:
00:92b5 : a5 44 __ LDA T6 + 0 
00:92b7 : 85 03 __ STA WORK + 0 
00:92b9 : a9 00 __ LDA #$00
00:92bb : 85 04 __ STA WORK + 1 
00:92bd : 20 18 a3 JSR $a318 ; (divmod + 0)
00:92c0 : a5 05 __ LDA WORK + 2 
00:92c2 : c9 0a __ CMP #$0a
00:92c4 : b0 04 __ BCS $92ca ; (nformi.s32 + 0)
.s30:
00:92c6 : a9 30 __ LDA #$30
00:92c8 : 90 06 __ BCC $92d0 ; (nformi.s31 + 0)
.s32:
00:92ca : a0 03 __ LDY #$03
00:92cc : b1 0d __ LDA (P0),y ; (si + 0)
00:92ce : e9 0a __ SBC #$0a
.s31:
00:92d0 : 18 __ __ CLC
00:92d1 : 65 05 __ ADC WORK + 2 
00:92d3 : a6 45 __ LDX T7 + 0 
00:92d5 : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:92d8 : c6 45 __ DEC T7 + 0 
00:92da : a5 1b __ LDA ACCU + 0 
00:92dc : 05 1c __ ORA ACCU + 1 
00:92de : d0 d5 __ BNE $92b5 ; (nformi.l29 + 0)
.s6:
00:92e0 : a0 02 __ LDY #$02
00:92e2 : b1 0d __ LDA (P0),y ; (si + 0)
00:92e4 : c9 ff __ CMP #$ff
00:92e6 : d0 04 __ BNE $92ec ; (nformi.s27 + 0)
.s7:
00:92e8 : a9 0f __ LDA #$0f
00:92ea : d0 05 __ BNE $92f1 ; (nformi.s39 + 0)
.s27:
00:92ec : 38 __ __ SEC
00:92ed : a9 10 __ LDA #$10
00:92ef : f1 0d __ SBC (P0),y ; (si + 0)
.s39:
00:92f1 : a8 __ __ TAY
00:92f2 : c4 45 __ CPY T7 + 0 
00:92f4 : b0 0d __ BCS $9303 ; (nformi.s8 + 0)
.s26:
00:92f6 : a9 30 __ LDA #$30
.l40:
00:92f8 : a6 45 __ LDX T7 + 0 
00:92fa : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:92fd : c6 45 __ DEC T7 + 0 
00:92ff : c4 45 __ CPY T7 + 0 
00:9301 : 90 f5 __ BCC $92f8 ; (nformi.l40 + 0)
.s8:
00:9303 : a0 07 __ LDY #$07
00:9305 : b1 0d __ LDA (P0),y ; (si + 0)
00:9307 : f0 1c __ BEQ $9325 ; (nformi.s9 + 0)
.s24:
00:9309 : a5 44 __ LDA T6 + 0 
00:930b : c9 10 __ CMP #$10
00:930d : d0 16 __ BNE $9325 ; (nformi.s9 + 0)
.s25:
00:930f : a0 03 __ LDY #$03
00:9311 : b1 0d __ LDA (P0),y ; (si + 0)
00:9313 : a8 __ __ TAY
00:9314 : a9 30 __ LDA #$30
00:9316 : a6 45 __ LDX T7 + 0 
00:9318 : ca __ __ DEX
00:9319 : ca __ __ DEX
00:931a : 86 45 __ STX T7 + 0 
00:931c : 9d e6 46 STA $46e6,x ; (buffer[0] + 0)
00:931f : 98 __ __ TYA
00:9320 : 69 16 __ ADC #$16
00:9322 : 9d e7 46 STA $46e7,x ; (buffer[0] + 1)
.s9:
00:9325 : a9 00 __ LDA #$00
00:9327 : 85 1b __ STA ACCU + 0 
00:9329 : a5 43 __ LDA T5 + 0 
00:932b : f0 0c __ BEQ $9339 ; (nformi.s10 + 0)
.s23:
00:932d : a9 2d __ LDA #$2d
.s22:
00:932f : a6 45 __ LDX T7 + 0 
00:9331 : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:9334 : c6 45 __ DEC T7 + 0 
00:9336 : 4c 43 93 JMP $9343 ; (nformi.s11 + 0)
.s10:
00:9339 : a0 05 __ LDY #$05
00:933b : b1 0d __ LDA (P0),y ; (si + 0)
00:933d : f0 04 __ BEQ $9343 ; (nformi.s11 + 0)
.s21:
00:933f : a9 2b __ LDA #$2b
00:9341 : d0 ec __ BNE $932f ; (nformi.s22 + 0)
.s11:
00:9343 : a0 06 __ LDY #$06
00:9345 : a6 45 __ LDX T7 + 0 
00:9347 : b1 0d __ LDA (P0),y ; (si + 0)
00:9349 : d0 2b __ BNE $9376 ; (nformi.s17 + 0)
.l12:
00:934b : 8a __ __ TXA
00:934c : 18 __ __ CLC
00:934d : a0 01 __ LDY #$01
00:934f : 71 0d __ ADC (P0),y ; (si + 0)
00:9351 : b0 04 __ BCS $9357 ; (nformi.s15 + 0)
.s16:
00:9353 : c9 11 __ CMP #$11
00:9355 : 90 0a __ BCC $9361 ; (nformi.s13 + 0)
.s15:
00:9357 : a0 00 __ LDY #$00
00:9359 : b1 0d __ LDA (P0),y ; (si + 0)
00:935b : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:935e : ca __ __ DEX
00:935f : b0 ea __ BCS $934b ; (nformi.l12 + 0)
.s13:
00:9361 : e0 10 __ CPX #$10
00:9363 : b0 0e __ BCS $9373 ; (nformi.s41 + 0)
.s14:
00:9365 : 88 __ __ DEY
.l37:
00:9366 : bd e6 46 LDA $46e6,x ; (buffer[0] + 0)
00:9369 : 91 0f __ STA (P2),y ; (str + 0)
00:936b : c8 __ __ INY
00:936c : e8 __ __ INX
00:936d : e0 10 __ CPX #$10
00:936f : 90 f5 __ BCC $9366 ; (nformi.l37 + 0)
.s38:
00:9371 : 84 1b __ STY ACCU + 0 
.s41:
00:9373 : a5 1b __ LDA ACCU + 0 
.s3:
00:9375 : 60 __ __ RTS
.s17:
00:9376 : e0 10 __ CPX #$10
00:9378 : b0 1a __ BCS $9394 ; (nformi.l18 + 0)
.s20:
00:937a : a0 00 __ LDY #$00
.l35:
00:937c : bd e6 46 LDA $46e6,x ; (buffer[0] + 0)
00:937f : 91 0f __ STA (P2),y ; (str + 0)
00:9381 : c8 __ __ INY
00:9382 : e8 __ __ INX
00:9383 : e0 10 __ CPX #$10
00:9385 : 90 f5 __ BCC $937c ; (nformi.l35 + 0)
.s36:
00:9387 : 84 1b __ STY ACCU + 0 
00:9389 : b0 09 __ BCS $9394 ; (nformi.l18 + 0)
.s19:
00:938b : 88 __ __ DEY
00:938c : b1 0d __ LDA (P0),y ; (si + 0)
00:938e : a4 1b __ LDY ACCU + 0 
00:9390 : 91 0f __ STA (P2),y ; (str + 0)
00:9392 : e6 1b __ INC ACCU + 0 
.l18:
00:9394 : a5 1b __ LDA ACCU + 0 
00:9396 : a0 01 __ LDY #$01
00:9398 : d1 0d __ CMP (P0),y ; (si + 0)
00:939a : 90 ef __ BCC $938b ; (nformi.s19 + 0)
00:939c : 60 __ __ RTS
--------------------------------------------------------------------
nforml: ; nforml(const struct sinfo*,u8*,i32,bool)->u8
; 137, "/usr/local/include/oscar64/stdio.c"
.s4:
00:939d : a9 00 __ LDA #$00
00:939f : 85 43 __ STA T4 + 0 
00:93a1 : a5 15 __ LDA P8 ; (s + 0)
00:93a3 : f0 1f __ BEQ $93c4 ; (nforml.s5 + 0)
.s35:
00:93a5 : 24 14 __ BIT P7 ; (v + 3)
00:93a7 : 10 1b __ BPL $93c4 ; (nforml.s5 + 0)
.s36:
00:93a9 : 38 __ __ SEC
00:93aa : a9 00 __ LDA #$00
00:93ac : e5 11 __ SBC P4 ; (v + 0)
00:93ae : 85 11 __ STA P4 ; (v + 0)
00:93b0 : a9 00 __ LDA #$00
00:93b2 : e5 12 __ SBC P5 ; (v + 1)
00:93b4 : 85 12 __ STA P5 ; (v + 1)
00:93b6 : a9 00 __ LDA #$00
00:93b8 : e5 13 __ SBC P6 ; (v + 2)
00:93ba : 85 13 __ STA P6 ; (v + 2)
00:93bc : a9 00 __ LDA #$00
00:93be : e5 14 __ SBC P7 ; (v + 3)
00:93c0 : 85 14 __ STA P7 ; (v + 3)
00:93c2 : e6 43 __ INC T4 + 0 
.s5:
00:93c4 : a9 10 __ LDA #$10
00:93c6 : 85 44 __ STA T5 + 0 
00:93c8 : a5 14 __ LDA P7 ; (v + 3)
00:93ca : f0 03 __ BEQ $93cf ; (nforml.s31 + 0)
00:93cc : 4c 97 94 JMP $9497 ; (nforml.l28 + 0)
.s31:
00:93cf : a5 13 __ LDA P6 ; (v + 2)
00:93d1 : d0 f9 __ BNE $93cc ; (nforml.s5 + 8)
.s32:
00:93d3 : a5 12 __ LDA P5 ; (v + 1)
00:93d5 : d0 f5 __ BNE $93cc ; (nforml.s5 + 8)
.s33:
00:93d7 : c5 11 __ CMP P4 ; (v + 0)
00:93d9 : 90 f1 __ BCC $93cc ; (nforml.s5 + 8)
.s6:
00:93db : a0 02 __ LDY #$02
00:93dd : b1 0d __ LDA (P0),y ; (si + 0)
00:93df : c9 ff __ CMP #$ff
00:93e1 : d0 04 __ BNE $93e7 ; (nforml.s27 + 0)
.s7:
00:93e3 : a9 0f __ LDA #$0f
00:93e5 : d0 05 __ BNE $93ec ; (nforml.s41 + 0)
.s27:
00:93e7 : 38 __ __ SEC
00:93e8 : a9 10 __ LDA #$10
00:93ea : f1 0d __ SBC (P0),y ; (si + 0)
.s41:
00:93ec : a8 __ __ TAY
00:93ed : c4 44 __ CPY T5 + 0 
00:93ef : b0 0d __ BCS $93fe ; (nforml.s8 + 0)
.s26:
00:93f1 : a9 30 __ LDA #$30
.l42:
00:93f3 : a6 44 __ LDX T5 + 0 
00:93f5 : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:93f8 : c6 44 __ DEC T5 + 0 
00:93fa : c4 44 __ CPY T5 + 0 
00:93fc : 90 f5 __ BCC $93f3 ; (nforml.l42 + 0)
.s8:
00:93fe : a0 07 __ LDY #$07
00:9400 : b1 0d __ LDA (P0),y ; (si + 0)
00:9402 : f0 1d __ BEQ $9421 ; (nforml.s9 + 0)
.s24:
00:9404 : a0 04 __ LDY #$04
00:9406 : b1 0d __ LDA (P0),y ; (si + 0)
00:9408 : c9 10 __ CMP #$10
00:940a : d0 15 __ BNE $9421 ; (nforml.s9 + 0)
.s25:
00:940c : 88 __ __ DEY
00:940d : b1 0d __ LDA (P0),y ; (si + 0)
00:940f : a8 __ __ TAY
00:9410 : a9 30 __ LDA #$30
00:9412 : a6 44 __ LDX T5 + 0 
00:9414 : ca __ __ DEX
00:9415 : ca __ __ DEX
00:9416 : 86 44 __ STX T5 + 0 
00:9418 : 9d e6 46 STA $46e6,x ; (buffer[0] + 0)
00:941b : 98 __ __ TYA
00:941c : 69 16 __ ADC #$16
00:941e : 9d e7 46 STA $46e7,x ; (buffer[0] + 1)
.s9:
00:9421 : a9 00 __ LDA #$00
00:9423 : 85 1b __ STA ACCU + 0 
00:9425 : a5 43 __ LDA T4 + 0 
00:9427 : f0 0c __ BEQ $9435 ; (nforml.s10 + 0)
.s23:
00:9429 : a9 2d __ LDA #$2d
.s22:
00:942b : a6 44 __ LDX T5 + 0 
00:942d : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:9430 : c6 44 __ DEC T5 + 0 
00:9432 : 4c 3f 94 JMP $943f ; (nforml.s11 + 0)
.s10:
00:9435 : a0 05 __ LDY #$05
00:9437 : b1 0d __ LDA (P0),y ; (si + 0)
00:9439 : f0 04 __ BEQ $943f ; (nforml.s11 + 0)
.s21:
00:943b : a9 2b __ LDA #$2b
00:943d : d0 ec __ BNE $942b ; (nforml.s22 + 0)
.s11:
00:943f : a6 44 __ LDX T5 + 0 
00:9441 : a0 06 __ LDY #$06
00:9443 : b1 0d __ LDA (P0),y ; (si + 0)
00:9445 : d0 29 __ BNE $9470 ; (nforml.s17 + 0)
.l12:
00:9447 : 8a __ __ TXA
00:9448 : 18 __ __ CLC
00:9449 : a0 01 __ LDY #$01
00:944b : 71 0d __ ADC (P0),y ; (si + 0)
00:944d : b0 04 __ BCS $9453 ; (nforml.s15 + 0)
.s16:
00:944f : c9 11 __ CMP #$11
00:9451 : 90 0a __ BCC $945d ; (nforml.s13 + 0)
.s15:
00:9453 : a0 00 __ LDY #$00
00:9455 : b1 0d __ LDA (P0),y ; (si + 0)
00:9457 : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:945a : ca __ __ DEX
00:945b : b0 ea __ BCS $9447 ; (nforml.l12 + 0)
.s13:
00:945d : e0 10 __ CPX #$10
00:945f : b0 0e __ BCS $946f ; (nforml.s3 + 0)
.s14:
00:9461 : 88 __ __ DEY
.l39:
00:9462 : bd e6 46 LDA $46e6,x ; (buffer[0] + 0)
00:9465 : 91 0f __ STA (P2),y ; (str + 0)
00:9467 : c8 __ __ INY
00:9468 : e8 __ __ INX
00:9469 : e0 10 __ CPX #$10
00:946b : 90 f5 __ BCC $9462 ; (nforml.l39 + 0)
.s40:
00:946d : 84 1b __ STY ACCU + 0 
.s3:
00:946f : 60 __ __ RTS
.s17:
00:9470 : e0 10 __ CPX #$10
00:9472 : b0 1a __ BCS $948e ; (nforml.l18 + 0)
.s20:
00:9474 : a0 00 __ LDY #$00
.l37:
00:9476 : bd e6 46 LDA $46e6,x ; (buffer[0] + 0)
00:9479 : 91 0f __ STA (P2),y ; (str + 0)
00:947b : c8 __ __ INY
00:947c : e8 __ __ INX
00:947d : e0 10 __ CPX #$10
00:947f : 90 f5 __ BCC $9476 ; (nforml.l37 + 0)
.s38:
00:9481 : 84 1b __ STY ACCU + 0 
00:9483 : b0 09 __ BCS $948e ; (nforml.l18 + 0)
.s19:
00:9485 : 88 __ __ DEY
00:9486 : b1 0d __ LDA (P0),y ; (si + 0)
00:9488 : a4 1b __ LDY ACCU + 0 
00:948a : 91 0f __ STA (P2),y ; (str + 0)
00:948c : e6 1b __ INC ACCU + 0 
.l18:
00:948e : a5 1b __ LDA ACCU + 0 
00:9490 : a0 01 __ LDY #$01
00:9492 : d1 0d __ CMP (P0),y ; (si + 0)
00:9494 : 90 ef __ BCC $9485 ; (nforml.s19 + 0)
00:9496 : 60 __ __ RTS
.l28:
00:9497 : a0 04 __ LDY #$04
00:9499 : b1 0d __ LDA (P0),y ; (si + 0)
00:949b : 85 03 __ STA WORK + 0 
00:949d : a5 11 __ LDA P4 ; (v + 0)
00:949f : 85 1b __ STA ACCU + 0 
00:94a1 : a5 12 __ LDA P5 ; (v + 1)
00:94a3 : 85 1c __ STA ACCU + 1 
00:94a5 : a5 13 __ LDA P6 ; (v + 2)
00:94a7 : 85 1d __ STA ACCU + 2 
00:94a9 : a5 14 __ LDA P7 ; (v + 3)
00:94ab : 85 1e __ STA ACCU + 3 
00:94ad : a9 00 __ LDA #$00
00:94af : 85 04 __ STA WORK + 1 
00:94b1 : 85 05 __ STA WORK + 2 
00:94b3 : 85 06 __ STA WORK + 3 
00:94b5 : 20 a5 a4 JSR $a4a5 ; (divmod32 + 0)
00:94b8 : a5 07 __ LDA WORK + 4 
00:94ba : c9 0a __ CMP #$0a
00:94bc : b0 04 __ BCS $94c2 ; (nforml.s34 + 0)
.s29:
00:94be : a9 30 __ LDA #$30
00:94c0 : 90 06 __ BCC $94c8 ; (nforml.s30 + 0)
.s34:
00:94c2 : a0 03 __ LDY #$03
00:94c4 : b1 0d __ LDA (P0),y ; (si + 0)
00:94c6 : e9 0a __ SBC #$0a
.s30:
00:94c8 : 18 __ __ CLC
00:94c9 : 65 07 __ ADC WORK + 4 
00:94cb : a6 44 __ LDX T5 + 0 
00:94cd : 9d e5 46 STA $46e5,x ; (si.prefix + 0)
00:94d0 : c6 44 __ DEC T5 + 0 
00:94d2 : a5 1b __ LDA ACCU + 0 
00:94d4 : 85 11 __ STA P4 ; (v + 0)
00:94d6 : a5 1c __ LDA ACCU + 1 
00:94d8 : 85 12 __ STA P5 ; (v + 1)
00:94da : a5 1d __ LDA ACCU + 2 
00:94dc : 85 13 __ STA P6 ; (v + 2)
00:94de : a5 1e __ LDA ACCU + 3 
00:94e0 : 85 14 __ STA P7 ; (v + 3)
00:94e2 : d0 b3 __ BNE $9497 ; (nforml.l28 + 0)
00:94e4 : 4c cf 93 JMP $93cf ; (nforml.s31 + 0)
--------------------------------------------------------------------
nformf: ; nformf(const struct sinfo*,u8*,float,u8)->u8
; 199, "/usr/local/include/oscar64/stdio.c"
.s1:
00:94e7 : a5 53 __ LDA T10 + 0 
00:94e9 : 8d ed 46 STA $46ed ; (nformf@stack + 0)
00:94ec : a5 54 __ LDA T11 + 0 
00:94ee : 8d ee 46 STA $46ee ; (nformf@stack + 1)
.s4:
00:94f1 : a5 11 __ LDA P4 ; (f + 0)
00:94f3 : 85 43 __ STA T0 + 0 
00:94f5 : a5 12 __ LDA P5 ; (f + 1)
00:94f7 : 85 44 __ STA T0 + 1 
00:94f9 : a5 14 __ LDA P7 ; (f + 3)
00:94fb : 29 7f __ AND #$7f
00:94fd : 05 13 __ ORA P6 ; (f + 2)
00:94ff : 05 12 __ ORA P5 ; (f + 1)
00:9501 : a6 13 __ LDX P6 ; (f + 2)
00:9503 : 86 45 __ STX T0 + 2 
00:9505 : 05 11 __ ORA P4 ; (f + 0)
00:9507 : f0 14 __ BEQ $951d ; (nformf.s5 + 0)
.s105:
00:9509 : 24 14 __ BIT P7 ; (f + 3)
00:950b : 10 10 __ BPL $951d ; (nformf.s5 + 0)
.s104:
00:950d : a9 2d __ LDA #$2d
00:950f : a0 00 __ LDY #$00
00:9511 : 91 0f __ STA (P2),y ; (str + 0)
00:9513 : a5 14 __ LDA P7 ; (f + 3)
00:9515 : 49 80 __ EOR #$80
00:9517 : 85 14 __ STA P7 ; (f + 3)
.s103:
00:9519 : a9 01 __ LDA #$01
00:951b : d0 0e __ BNE $952b ; (nformf.s6 + 0)
.s5:
00:951d : a0 05 __ LDY #$05
00:951f : b1 0d __ LDA (P0),y ; (si + 0)
00:9521 : f0 08 __ BEQ $952b ; (nformf.s6 + 0)
.s102:
00:9523 : a9 2b __ LDA #$2b
00:9525 : a0 00 __ LDY #$00
00:9527 : 91 0f __ STA (P2),y ; (str + 0)
00:9529 : a9 01 __ LDA #$01
.s6:
00:952b : 85 52 __ STA T9 + 0 
00:952d : 8a __ __ TXA
00:952e : 0a __ __ ASL
00:952f : a5 14 __ LDA P7 ; (f + 3)
00:9531 : 2a __ __ ROL
00:9532 : c9 ff __ CMP #$ff
00:9534 : d0 29 __ BNE $955f ; (nformf.s7 + 0)
.s101:
00:9536 : a0 03 __ LDY #$03
00:9538 : b1 0d __ LDA (P0),y ; (si + 0)
00:953a : 69 07 __ ADC #$07
00:953c : a4 52 __ LDY T9 + 0 
00:953e : 91 0f __ STA (P2),y ; (str + 0)
00:9540 : 18 __ __ CLC
00:9541 : a0 03 __ LDY #$03
00:9543 : b1 0d __ LDA (P0),y ; (si + 0)
00:9545 : 69 0d __ ADC #$0d
00:9547 : a4 52 __ LDY T9 + 0 
00:9549 : c8 __ __ INY
00:954a : 91 0f __ STA (P2),y ; (str + 0)
00:954c : 18 __ __ CLC
00:954d : a0 03 __ LDY #$03
00:954f : b1 0d __ LDA (P0),y ; (si + 0)
00:9551 : 69 05 __ ADC #$05
00:9553 : a4 52 __ LDY T9 + 0 
00:9555 : c8 __ __ INY
00:9556 : c8 __ __ INY
00:9557 : 91 0f __ STA (P2),y ; (str + 0)
00:9559 : c8 __ __ INY
00:955a : 84 52 __ STY T9 + 0 
00:955c : 4c ad 98 JMP $98ad ; (nformf.s27 + 0)
.s7:
00:955f : a0 02 __ LDY #$02
00:9561 : b1 0d __ LDA (P0),y ; (si + 0)
00:9563 : a6 14 __ LDX P7 ; (f + 3)
00:9565 : 86 46 __ STX T0 + 3 
00:9567 : c9 ff __ CMP #$ff
00:9569 : d0 02 __ BNE $956d ; (nformf.s100 + 0)
.s8:
00:956b : a9 06 __ LDA #$06
.s100:
00:956d : 85 4b __ STA T4 + 0 
00:956f : 85 50 __ STA T7 + 0 
00:9571 : a9 00 __ LDA #$00
00:9573 : 85 4d __ STA T5 + 0 
00:9575 : 85 4e __ STA T5 + 1 
00:9577 : 8a __ __ TXA
00:9578 : 29 7f __ AND #$7f
00:957a : 05 13 __ ORA P6 ; (f + 2)
00:957c : 05 12 __ ORA P5 ; (f + 1)
00:957e : 05 11 __ ORA P4 ; (f + 0)
00:9580 : d0 03 __ BNE $9585 ; (nformf.s67 + 0)
00:9582 : 4c b1 96 JMP $96b1 ; (nformf.s9 + 0)
.s67:
00:9585 : 8a __ __ TXA
00:9586 : 10 03 __ BPL $958b ; (nformf.s95 + 0)
00:9588 : 4c 0b 96 JMP $960b ; (nformf.l80 + 0)
.s95:
00:958b : c9 44 __ CMP #$44
00:958d : d0 0e __ BNE $959d ; (nformf.l99 + 0)
.s96:
00:958f : a5 13 __ LDA P6 ; (f + 2)
00:9591 : c9 7a __ CMP #$7a
00:9593 : d0 08 __ BNE $959d ; (nformf.l99 + 0)
.s97:
00:9595 : a5 12 __ LDA P5 ; (f + 1)
00:9597 : d0 04 __ BNE $959d ; (nformf.l99 + 0)
.s98:
00:9599 : a5 11 __ LDA P4 ; (f + 0)
00:959b : f0 02 __ BEQ $959f ; (nformf.l90 + 0)
.l99:
00:959d : 90 54 __ BCC $95f3 ; (nformf.s68 + 0)
.l90:
00:959f : 18 __ __ CLC
00:95a0 : a5 4d __ LDA T5 + 0 
00:95a2 : 69 03 __ ADC #$03
00:95a4 : 85 4d __ STA T5 + 0 
00:95a6 : 90 02 __ BCC $95aa ; (nformf.s119 + 0)
.s118:
00:95a8 : e6 4e __ INC T5 + 1 
.s119:
00:95aa : a5 43 __ LDA T0 + 0 
00:95ac : 85 1b __ STA ACCU + 0 
00:95ae : a5 44 __ LDA T0 + 1 
00:95b0 : 85 1c __ STA ACCU + 1 
00:95b2 : a5 45 __ LDA T0 + 2 
00:95b4 : 85 1d __ STA ACCU + 2 
00:95b6 : a5 46 __ LDA T0 + 3 
00:95b8 : 85 1e __ STA ACCU + 3 
00:95ba : a9 00 __ LDA #$00
00:95bc : 85 03 __ STA WORK + 0 
00:95be : 85 04 __ STA WORK + 1 
00:95c0 : a9 7a __ LDA #$7a
00:95c2 : 85 05 __ STA WORK + 2 
00:95c4 : a9 44 __ LDA #$44
00:95c6 : 85 06 __ STA WORK + 3 
00:95c8 : 20 4d a0 JSR $a04d ; (freg + 20)
00:95cb : 20 33 a2 JSR $a233 ; (crt_fdiv + 0)
00:95ce : a5 1b __ LDA ACCU + 0 
00:95d0 : 85 43 __ STA T0 + 0 
00:95d2 : a5 1c __ LDA ACCU + 1 
00:95d4 : 85 44 __ STA T0 + 1 
00:95d6 : a6 1d __ LDX ACCU + 2 
00:95d8 : 86 45 __ STX T0 + 2 
00:95da : a5 1e __ LDA ACCU + 3 
00:95dc : 85 46 __ STA T0 + 3 
00:95de : 30 13 __ BMI $95f3 ; (nformf.s68 + 0)
.s91:
00:95e0 : c9 44 __ CMP #$44
00:95e2 : d0 b9 __ BNE $959d ; (nformf.l99 + 0)
.s92:
00:95e4 : e0 7a __ CPX #$7a
00:95e6 : d0 b5 __ BNE $959d ; (nformf.l99 + 0)
.s93:
00:95e8 : a5 1c __ LDA ACCU + 1 
00:95ea : 38 __ __ SEC
00:95eb : d0 b0 __ BNE $959d ; (nformf.l99 + 0)
.s94:
00:95ed : a5 1b __ LDA ACCU + 0 
00:95ef : f0 ae __ BEQ $959f ; (nformf.l90 + 0)
00:95f1 : d0 aa __ BNE $959d ; (nformf.l99 + 0)
.s68:
00:95f3 : a5 46 __ LDA T0 + 3 
00:95f5 : 30 14 __ BMI $960b ; (nformf.l80 + 0)
.s86:
00:95f7 : c9 3f __ CMP #$3f
00:95f9 : d0 0e __ BNE $9609 ; (nformf.s85 + 0)
.s87:
00:95fb : a5 45 __ LDA T0 + 2 
00:95fd : c9 80 __ CMP #$80
00:95ff : d0 08 __ BNE $9609 ; (nformf.s85 + 0)
.s88:
00:9601 : a5 44 __ LDA T0 + 1 
00:9603 : d0 04 __ BNE $9609 ; (nformf.s85 + 0)
.s89:
00:9605 : a5 43 __ LDA T0 + 0 
00:9607 : f0 49 __ BEQ $9652 ; (nformf.s69 + 0)
.s85:
00:9609 : b0 47 __ BCS $9652 ; (nformf.s69 + 0)
.l80:
00:960b : 38 __ __ SEC
00:960c : a5 4d __ LDA T5 + 0 
00:960e : e9 03 __ SBC #$03
00:9610 : 85 4d __ STA T5 + 0 
00:9612 : b0 02 __ BCS $9616 ; (nformf.s114 + 0)
.s113:
00:9614 : c6 4e __ DEC T5 + 1 
.s114:
00:9616 : a9 00 __ LDA #$00
00:9618 : 85 1b __ STA ACCU + 0 
00:961a : 85 1c __ STA ACCU + 1 
00:961c : a9 7a __ LDA #$7a
00:961e : 85 1d __ STA ACCU + 2 
00:9620 : a9 44 __ LDA #$44
00:9622 : 85 1e __ STA ACCU + 3 
00:9624 : a2 43 __ LDX #$43
00:9626 : 20 3d a0 JSR $a03d ; (freg + 4)
00:9629 : 20 6b a1 JSR $a16b ; (crt_fmul + 0)
00:962c : a5 1b __ LDA ACCU + 0 
00:962e : 85 43 __ STA T0 + 0 
00:9630 : a5 1c __ LDA ACCU + 1 
00:9632 : 85 44 __ STA T0 + 1 
00:9634 : a6 1d __ LDX ACCU + 2 
00:9636 : 86 45 __ STX T0 + 2 
00:9638 : a5 1e __ LDA ACCU + 3 
00:963a : 85 46 __ STA T0 + 3 
00:963c : 30 cd __ BMI $960b ; (nformf.l80 + 0)
.s81:
00:963e : c9 3f __ CMP #$3f
00:9640 : 90 c9 __ BCC $960b ; (nformf.l80 + 0)
.s120:
00:9642 : d0 0e __ BNE $9652 ; (nformf.s69 + 0)
.s82:
00:9644 : e0 80 __ CPX #$80
00:9646 : 90 c3 __ BCC $960b ; (nformf.l80 + 0)
.s121:
00:9648 : d0 08 __ BNE $9652 ; (nformf.s69 + 0)
.s83:
00:964a : a5 1c __ LDA ACCU + 1 
00:964c : d0 bb __ BNE $9609 ; (nformf.s85 + 0)
.s84:
00:964e : a5 1b __ LDA ACCU + 0 
00:9650 : d0 b7 __ BNE $9609 ; (nformf.s85 + 0)
.s69:
00:9652 : a5 46 __ LDA T0 + 3 
00:9654 : 30 5b __ BMI $96b1 ; (nformf.s9 + 0)
.s75:
00:9656 : c9 41 __ CMP #$41
00:9658 : d0 0e __ BNE $9668 ; (nformf.l79 + 0)
.s76:
00:965a : a5 45 __ LDA T0 + 2 
00:965c : c9 20 __ CMP #$20
00:965e : d0 08 __ BNE $9668 ; (nformf.l79 + 0)
.s77:
00:9660 : a5 44 __ LDA T0 + 1 
00:9662 : d0 04 __ BNE $9668 ; (nformf.l79 + 0)
.s78:
00:9664 : a5 43 __ LDA T0 + 0 
00:9666 : f0 02 __ BEQ $966a ; (nformf.l70 + 0)
.l79:
00:9668 : 90 47 __ BCC $96b1 ; (nformf.s9 + 0)
.l70:
00:966a : e6 4d __ INC T5 + 0 
00:966c : d0 02 __ BNE $9670 ; (nformf.s117 + 0)
.s116:
00:966e : e6 4e __ INC T5 + 1 
.s117:
00:9670 : a5 43 __ LDA T0 + 0 
00:9672 : 85 1b __ STA ACCU + 0 
00:9674 : a5 44 __ LDA T0 + 1 
00:9676 : 85 1c __ STA ACCU + 1 
00:9678 : a5 45 __ LDA T0 + 2 
00:967a : 85 1d __ STA ACCU + 2 
00:967c : a5 46 __ LDA T0 + 3 
00:967e : 85 1e __ STA ACCU + 3 
00:9680 : a9 00 __ LDA #$00
00:9682 : 85 03 __ STA WORK + 0 
00:9684 : 85 04 __ STA WORK + 1 
00:9686 : 20 fe a6 JSR $a6fe ; (freg@proxy + 0)
00:9689 : 20 33 a2 JSR $a233 ; (crt_fdiv + 0)
00:968c : a5 1b __ LDA ACCU + 0 
00:968e : 85 43 __ STA T0 + 0 
00:9690 : a5 1c __ LDA ACCU + 1 
00:9692 : 85 44 __ STA T0 + 1 
00:9694 : a6 1d __ LDX ACCU + 2 
00:9696 : 86 45 __ STX T0 + 2 
00:9698 : a5 1e __ LDA ACCU + 3 
00:969a : 85 46 __ STA T0 + 3 
00:969c : 30 13 __ BMI $96b1 ; (nformf.s9 + 0)
.s71:
00:969e : c9 41 __ CMP #$41
00:96a0 : d0 c6 __ BNE $9668 ; (nformf.l79 + 0)
.s72:
00:96a2 : e0 20 __ CPX #$20
00:96a4 : d0 c2 __ BNE $9668 ; (nformf.l79 + 0)
.s73:
00:96a6 : a5 1c __ LDA ACCU + 1 
00:96a8 : 38 __ __ SEC
00:96a9 : d0 bd __ BNE $9668 ; (nformf.l79 + 0)
.s74:
00:96ab : a5 1b __ LDA ACCU + 0 
00:96ad : f0 bb __ BEQ $966a ; (nformf.l70 + 0)
00:96af : d0 b7 __ BNE $9668 ; (nformf.l79 + 0)
.s9:
00:96b1 : a5 15 __ LDA P8 ; (type + 0)
00:96b3 : c9 65 __ CMP #$65
00:96b5 : d0 04 __ BNE $96bb ; (nformf.s11 + 0)
.s10:
00:96b7 : a9 01 __ LDA #$01
00:96b9 : d0 02 __ BNE $96bd ; (nformf.s12 + 0)
.s11:
00:96bb : a9 00 __ LDA #$00
.s12:
00:96bd : 85 53 __ STA T10 + 0 
00:96bf : a6 4b __ LDX T4 + 0 
00:96c1 : e8 __ __ INX
00:96c2 : 86 4f __ STX T6 + 0 
00:96c4 : a5 15 __ LDA P8 ; (type + 0)
00:96c6 : c9 67 __ CMP #$67
00:96c8 : d0 13 __ BNE $96dd ; (nformf.s13 + 0)
.s63:
00:96ca : a5 4e __ LDA T5 + 1 
00:96cc : 30 08 __ BMI $96d6 ; (nformf.s64 + 0)
.s66:
00:96ce : d0 06 __ BNE $96d6 ; (nformf.s64 + 0)
.s65:
00:96d0 : a5 4d __ LDA T5 + 0 
00:96d2 : c9 04 __ CMP #$04
00:96d4 : 90 07 __ BCC $96dd ; (nformf.s13 + 0)
.s64:
00:96d6 : a9 01 __ LDA #$01
00:96d8 : 85 53 __ STA T10 + 0 
00:96da : 4c 3e 99 JMP $993e ; (nformf.s53 + 0)
.s13:
00:96dd : a5 53 __ LDA T10 + 0 
00:96df : d0 f9 __ BNE $96da ; (nformf.s64 + 4)
.s14:
00:96e1 : 24 4e __ BIT T5 + 1 
00:96e3 : 10 3b __ BPL $9720 ; (nformf.s15 + 0)
.s52:
00:96e5 : a5 43 __ LDA T0 + 0 
00:96e7 : 85 1b __ STA ACCU + 0 
00:96e9 : a5 44 __ LDA T0 + 1 
00:96eb : 85 1c __ STA ACCU + 1 
00:96ed : a5 45 __ LDA T0 + 2 
00:96ef : 85 1d __ STA ACCU + 2 
00:96f1 : a5 46 __ LDA T0 + 3 
00:96f3 : 85 1e __ STA ACCU + 3 
.l106:
00:96f5 : a9 00 __ LDA #$00
00:96f7 : 85 03 __ STA WORK + 0 
00:96f9 : 85 04 __ STA WORK + 1 
00:96fb : 20 fe a6 JSR $a6fe ; (freg@proxy + 0)
00:96fe : 20 33 a2 JSR $a233 ; (crt_fdiv + 0)
00:9701 : 18 __ __ CLC
00:9702 : a5 4d __ LDA T5 + 0 
00:9704 : 69 01 __ ADC #$01
00:9706 : 85 4d __ STA T5 + 0 
00:9708 : a5 4e __ LDA T5 + 1 
00:970a : 69 00 __ ADC #$00
00:970c : 85 4e __ STA T5 + 1 
00:970e : 30 e5 __ BMI $96f5 ; (nformf.l106 + 0)
.s107:
00:9710 : a5 1e __ LDA ACCU + 3 
00:9712 : 85 46 __ STA T0 + 3 
00:9714 : a5 1d __ LDA ACCU + 2 
00:9716 : 85 45 __ STA T0 + 2 
00:9718 : a5 1c __ LDA ACCU + 1 
00:971a : 85 44 __ STA T0 + 1 
00:971c : a5 1b __ LDA ACCU + 0 
00:971e : 85 43 __ STA T0 + 0 
.s15:
00:9720 : 18 __ __ CLC
00:9721 : a5 4b __ LDA T4 + 0 
00:9723 : 65 4d __ ADC T5 + 0 
00:9725 : 18 __ __ CLC
00:9726 : 69 01 __ ADC #$01
00:9728 : 85 4f __ STA T6 + 0 
00:972a : c9 07 __ CMP #$07
00:972c : 90 14 __ BCC $9742 ; (nformf.s51 + 0)
.s16:
00:972e : ad 7e a7 LDA $a77e ; (fround5[0] + 24)
00:9731 : 85 47 __ STA T1 + 0 
00:9733 : ad 7f a7 LDA $a77f ; (fround5[0] + 25)
00:9736 : 85 48 __ STA T1 + 1 
00:9738 : ad 80 a7 LDA $a780 ; (fround5[0] + 26)
00:973b : 85 49 __ STA T1 + 2 
00:973d : ad 81 a7 LDA $a781 ; (fround5[0] + 27)
00:9740 : b0 15 __ BCS $9757 ; (nformf.s17 + 0)
.s51:
00:9742 : 0a __ __ ASL
00:9743 : 0a __ __ ASL
00:9744 : aa __ __ TAX
00:9745 : bd 62 a7 LDA $a762,x ; (current_page + 0)
00:9748 : 85 47 __ STA T1 + 0 
00:974a : bd 63 a7 LDA $a763,x ; (current_page + 1)
00:974d : 85 48 __ STA T1 + 1 
00:974f : bd 64 a7 LDA $a764,x ; (search_query_len + 0)
00:9752 : 85 49 __ STA T1 + 2 
00:9754 : bd 65 a7 LDA $a765,x ; (search_query_len + 1)
.s17:
00:9757 : 85 4a __ STA T1 + 3 
00:9759 : a2 47 __ LDX #$47
00:975b : 20 09 a7 JSR $a709 ; (freg@proxy + 0)
00:975e : 20 84 a0 JSR $a084 ; (faddsub + 6)
00:9761 : a5 1c __ LDA ACCU + 1 
00:9763 : 85 12 __ STA P5 ; (f + 1)
00:9765 : a5 1d __ LDA ACCU + 2 
00:9767 : 85 13 __ STA P6 ; (f + 2)
00:9769 : a6 1b __ LDX ACCU + 0 
00:976b : a5 1e __ LDA ACCU + 3 
00:976d : 85 14 __ STA P7 ; (f + 3)
00:976f : 30 32 __ BMI $97a3 ; (nformf.s18 + 0)
.s46:
00:9771 : c9 41 __ CMP #$41
00:9773 : d0 0d __ BNE $9782 ; (nformf.s50 + 0)
.s47:
00:9775 : a5 13 __ LDA P6 ; (f + 2)
00:9777 : c9 20 __ CMP #$20
00:9779 : d0 07 __ BNE $9782 ; (nformf.s50 + 0)
.s48:
00:977b : a5 12 __ LDA P5 ; (f + 1)
00:977d : d0 03 __ BNE $9782 ; (nformf.s50 + 0)
.s49:
00:977f : 8a __ __ TXA
00:9780 : f0 02 __ BEQ $9784 ; (nformf.s45 + 0)
.s50:
00:9782 : 90 1f __ BCC $97a3 ; (nformf.s18 + 0)
.s45:
00:9784 : a9 00 __ LDA #$00
00:9786 : 85 03 __ STA WORK + 0 
00:9788 : 85 04 __ STA WORK + 1 
00:978a : 20 fe a6 JSR $a6fe ; (freg@proxy + 0)
00:978d : 20 33 a2 JSR $a233 ; (crt_fdiv + 0)
00:9790 : a5 1c __ LDA ACCU + 1 
00:9792 : 85 12 __ STA P5 ; (f + 1)
00:9794 : a5 1d __ LDA ACCU + 2 
00:9796 : 85 13 __ STA P6 ; (f + 2)
00:9798 : a5 1e __ LDA ACCU + 3 
00:979a : 85 14 __ STA P7 ; (f + 3)
00:979c : a6 4b __ LDX T4 + 0 
00:979e : ca __ __ DEX
00:979f : 86 50 __ STX T7 + 0 
00:97a1 : a6 1b __ LDX ACCU + 0 
.s18:
00:97a3 : 38 __ __ SEC
00:97a4 : a5 4f __ LDA T6 + 0 
00:97a6 : e5 50 __ SBC T7 + 0 
00:97a8 : 85 4b __ STA T4 + 0 
00:97aa : a9 00 __ LDA #$00
00:97ac : e9 00 __ SBC #$00
00:97ae : 85 4c __ STA T4 + 1 
00:97b0 : a9 14 __ LDA #$14
00:97b2 : c5 4f __ CMP T6 + 0 
00:97b4 : b0 02 __ BCS $97b8 ; (nformf.s19 + 0)
.s44:
00:97b6 : 85 4f __ STA T6 + 0 
.s19:
00:97b8 : a5 4b __ LDA T4 + 0 
00:97ba : d0 08 __ BNE $97c4 ; (nformf.s21 + 0)
.s20:
00:97bc : a9 30 __ LDA #$30
00:97be : a4 52 __ LDY T9 + 0 
00:97c0 : 91 0f __ STA (P2),y ; (str + 0)
00:97c2 : e6 52 __ INC T9 + 0 
.s21:
00:97c4 : a9 00 __ LDA #$00
00:97c6 : 85 54 __ STA T11 + 0 
00:97c8 : c5 4b __ CMP T4 + 0 
00:97ca : f0 67 __ BEQ $9833 ; (nformf.l43 + 0)
.s23:
00:97cc : c9 07 __ CMP #$07
00:97ce : 90 04 __ BCC $97d4 ; (nformf.s24 + 0)
.l42:
00:97d0 : a9 30 __ LDA #$30
00:97d2 : b0 4d __ BCS $9821 ; (nformf.l25 + 0)
.s24:
00:97d4 : 86 1b __ STX ACCU + 0 
00:97d6 : 86 43 __ STX T0 + 0 
00:97d8 : a5 12 __ LDA P5 ; (f + 1)
00:97da : 85 1c __ STA ACCU + 1 
00:97dc : 85 44 __ STA T0 + 1 
00:97de : a5 13 __ LDA P6 ; (f + 2)
00:97e0 : 85 1d __ STA ACCU + 2 
00:97e2 : 85 45 __ STA T0 + 2 
00:97e4 : a5 14 __ LDA P7 ; (f + 3)
00:97e6 : 85 1e __ STA ACCU + 3 
00:97e8 : 85 46 __ STA T0 + 3 
00:97ea : 20 f4 a3 JSR $a3f4 ; (f32_to_i16 + 0)
00:97ed : a5 1b __ LDA ACCU + 0 
00:97ef : 85 51 __ STA T8 + 0 
00:97f1 : 20 40 a4 JSR $a440 ; (sint16_to_float + 0)
00:97f4 : a2 43 __ LDX #$43
00:97f6 : 20 3d a0 JSR $a03d ; (freg + 4)
00:97f9 : a5 1e __ LDA ACCU + 3 
00:97fb : 49 80 __ EOR #$80
00:97fd : 85 1e __ STA ACCU + 3 
00:97ff : 20 84 a0 JSR $a084 ; (faddsub + 6)
00:9802 : a9 00 __ LDA #$00
00:9804 : 85 03 __ STA WORK + 0 
00:9806 : 85 04 __ STA WORK + 1 
00:9808 : 20 fe a6 JSR $a6fe ; (freg@proxy + 0)
00:980b : 20 6b a1 JSR $a16b ; (crt_fmul + 0)
00:980e : a5 1c __ LDA ACCU + 1 
00:9810 : 85 12 __ STA P5 ; (f + 1)
00:9812 : a5 1d __ LDA ACCU + 2 
00:9814 : 85 13 __ STA P6 ; (f + 2)
00:9816 : a5 1e __ LDA ACCU + 3 
00:9818 : 85 14 __ STA P7 ; (f + 3)
00:981a : 18 __ __ CLC
00:981b : a5 51 __ LDA T8 + 0 
00:981d : 69 30 __ ADC #$30
00:981f : a6 1b __ LDX ACCU + 0 
.l25:
00:9821 : a4 52 __ LDY T9 + 0 
00:9823 : 91 0f __ STA (P2),y ; (str + 0)
00:9825 : e6 52 __ INC T9 + 0 
00:9827 : e6 54 __ INC T11 + 0 
00:9829 : a5 54 __ LDA T11 + 0 
00:982b : c5 4f __ CMP T6 + 0 
00:982d : b0 14 __ BCS $9843 ; (nformf.s26 + 0)
.s22:
00:982f : c5 4b __ CMP T4 + 0 
00:9831 : d0 99 __ BNE $97cc ; (nformf.s23 + 0)
.l43:
00:9833 : a9 2e __ LDA #$2e
00:9835 : a4 52 __ LDY T9 + 0 
00:9837 : 91 0f __ STA (P2),y ; (str + 0)
00:9839 : e6 52 __ INC T9 + 0 
00:983b : a5 54 __ LDA T11 + 0 
00:983d : c9 07 __ CMP #$07
00:983f : 90 93 __ BCC $97d4 ; (nformf.s24 + 0)
00:9841 : b0 8d __ BCS $97d0 ; (nformf.l42 + 0)
.s26:
00:9843 : a5 53 __ LDA T10 + 0 
00:9845 : f0 66 __ BEQ $98ad ; (nformf.s27 + 0)
.s38:
00:9847 : a0 03 __ LDY #$03
00:9849 : b1 0d __ LDA (P0),y ; (si + 0)
00:984b : 69 03 __ ADC #$03
00:984d : a4 52 __ LDY T9 + 0 
00:984f : 91 0f __ STA (P2),y ; (str + 0)
00:9851 : c8 __ __ INY
00:9852 : 84 52 __ STY T9 + 0 
00:9854 : 24 4e __ BIT T5 + 1 
00:9856 : 30 06 __ BMI $985e ; (nformf.s41 + 0)
.s39:
00:9858 : a9 2b __ LDA #$2b
00:985a : 91 0f __ STA (P2),y ; (str + 0)
00:985c : d0 11 __ BNE $986f ; (nformf.s40 + 0)
.s41:
00:985e : a9 2d __ LDA #$2d
00:9860 : 91 0f __ STA (P2),y ; (str + 0)
00:9862 : 38 __ __ SEC
00:9863 : a9 00 __ LDA #$00
00:9865 : e5 4d __ SBC T5 + 0 
00:9867 : 85 4d __ STA T5 + 0 
00:9869 : a9 00 __ LDA #$00
00:986b : e5 4e __ SBC T5 + 1 
00:986d : 85 4e __ STA T5 + 1 
.s40:
00:986f : e6 52 __ INC T9 + 0 
00:9871 : a5 4d __ LDA T5 + 0 
00:9873 : 85 1b __ STA ACCU + 0 
00:9875 : a5 4e __ LDA T5 + 1 
00:9877 : 85 1c __ STA ACCU + 1 
00:9879 : a9 0a __ LDA #$0a
00:987b : 85 03 __ STA WORK + 0 
00:987d : a9 00 __ LDA #$00
00:987f : 85 04 __ STA WORK + 1 
00:9881 : 20 e1 a2 JSR $a2e1 ; (divs16 + 0)
00:9884 : 18 __ __ CLC
00:9885 : a5 1b __ LDA ACCU + 0 
00:9887 : 69 30 __ ADC #$30
00:9889 : a4 52 __ LDY T9 + 0 
00:988b : 91 0f __ STA (P2),y ; (str + 0)
00:988d : e6 52 __ INC T9 + 0 
00:988f : a5 4d __ LDA T5 + 0 
00:9891 : 85 1b __ STA ACCU + 0 
00:9893 : a5 4e __ LDA T5 + 1 
00:9895 : 85 1c __ STA ACCU + 1 
00:9897 : a9 0a __ LDA #$0a
00:9899 : 85 03 __ STA WORK + 0 
00:989b : a9 00 __ LDA #$00
00:989d : 85 04 __ STA WORK + 1 
00:989f : 20 9d a3 JSR $a39d ; (mods16 + 0)
00:98a2 : 18 __ __ CLC
00:98a3 : a5 05 __ LDA WORK + 2 
00:98a5 : 69 30 __ ADC #$30
00:98a7 : a4 52 __ LDY T9 + 0 
00:98a9 : 91 0f __ STA (P2),y ; (str + 0)
00:98ab : e6 52 __ INC T9 + 0 
.s27:
00:98ad : a5 52 __ LDA T9 + 0 
00:98af : a0 01 __ LDY #$01
00:98b1 : d1 0d __ CMP (P0),y ; (si + 0)
00:98b3 : b0 6d __ BCS $9922 ; (nformf.s3 + 0)
.s28:
00:98b5 : a0 06 __ LDY #$06
00:98b7 : b1 0d __ LDA (P0),y ; (si + 0)
00:98b9 : f0 04 __ BEQ $98bf ; (nformf.s29 + 0)
.s108:
00:98bb : a6 52 __ LDX T9 + 0 
00:98bd : 90 70 __ BCC $992f ; (nformf.l36 + 0)
.s29:
00:98bf : a5 52 __ LDA T9 + 0 
00:98c1 : f0 40 __ BEQ $9903 ; (nformf.s30 + 0)
.s35:
00:98c3 : e9 00 __ SBC #$00
00:98c5 : a8 __ __ TAY
00:98c6 : a9 00 __ LDA #$00
00:98c8 : e9 00 __ SBC #$00
00:98ca : aa __ __ TAX
00:98cb : 98 __ __ TYA
00:98cc : 18 __ __ CLC
00:98cd : 65 0f __ ADC P2 ; (str + 0)
00:98cf : 85 43 __ STA T0 + 0 
00:98d1 : 8a __ __ TXA
00:98d2 : 65 10 __ ADC P3 ; (str + 1)
00:98d4 : 85 44 __ STA T0 + 1 
00:98d6 : a9 01 __ LDA #$01
00:98d8 : 85 4b __ STA T4 + 0 
00:98da : a6 52 __ LDX T9 + 0 
00:98dc : 38 __ __ SEC
.l109:
00:98dd : a0 01 __ LDY #$01
00:98df : b1 0d __ LDA (P0),y ; (si + 0)
00:98e1 : e5 4b __ SBC T4 + 0 
00:98e3 : 85 47 __ STA T1 + 0 
00:98e5 : a9 00 __ LDA #$00
00:98e7 : e5 4c __ SBC T4 + 1 
00:98e9 : 18 __ __ CLC
00:98ea : 65 10 __ ADC P3 ; (str + 1)
00:98ec : 85 48 __ STA T1 + 1 
00:98ee : 88 __ __ DEY
00:98ef : b1 43 __ LDA (T0 + 0),y 
00:98f1 : a4 0f __ LDY P2 ; (str + 0)
00:98f3 : 91 47 __ STA (T1 + 0),y 
00:98f5 : a5 43 __ LDA T0 + 0 
00:98f7 : d0 02 __ BNE $98fb ; (nformf.s112 + 0)
.s111:
00:98f9 : c6 44 __ DEC T0 + 1 
.s112:
00:98fb : c6 43 __ DEC T0 + 0 
00:98fd : e6 4b __ INC T4 + 0 
00:98ff : e4 4b __ CPX T4 + 0 
00:9901 : b0 da __ BCS $98dd ; (nformf.l109 + 0)
.s30:
00:9903 : a9 00 __ LDA #$00
00:9905 : 85 4b __ STA T4 + 0 
00:9907 : 90 08 __ BCC $9911 ; (nformf.l31 + 0)
.s33:
00:9909 : a9 20 __ LDA #$20
00:990b : a4 4b __ LDY T4 + 0 
00:990d : 91 0f __ STA (P2),y ; (str + 0)
00:990f : e6 4b __ INC T4 + 0 
.l31:
00:9911 : a0 01 __ LDY #$01
00:9913 : b1 0d __ LDA (P0),y ; (si + 0)
00:9915 : 38 __ __ SEC
00:9916 : e5 52 __ SBC T9 + 0 
00:9918 : 90 ef __ BCC $9909 ; (nformf.s33 + 0)
.s34:
00:991a : c5 4b __ CMP T4 + 0 
00:991c : 90 02 __ BCC $9920 ; (nformf.s32 + 0)
.s110:
00:991e : d0 e9 __ BNE $9909 ; (nformf.s33 + 0)
.s32:
00:9920 : b1 0d __ LDA (P0),y ; (si + 0)
.s3:
00:9922 : 85 1b __ STA ACCU + 0 
00:9924 : ad ed 46 LDA $46ed ; (nformf@stack + 0)
00:9927 : 85 53 __ STA T10 + 0 
00:9929 : ad ee 46 LDA $46ee ; (nformf@stack + 1)
00:992c : 85 54 __ STA T11 + 0 
00:992e : 60 __ __ RTS
.l36:
00:992f : 8a __ __ TXA
00:9930 : a0 01 __ LDY #$01
00:9932 : d1 0d __ CMP (P0),y ; (si + 0)
00:9934 : b0 ea __ BCS $9920 ; (nformf.s32 + 0)
.s37:
00:9936 : a8 __ __ TAY
00:9937 : a9 20 __ LDA #$20
00:9939 : 91 0f __ STA (P2),y ; (str + 0)
00:993b : e8 __ __ INX
00:993c : 90 f1 __ BCC $992f ; (nformf.l36 + 0)
.s53:
00:993e : a5 4f __ LDA T6 + 0 
00:9940 : c9 07 __ CMP #$07
00:9942 : 90 14 __ BCC $9958 ; (nformf.s62 + 0)
.s54:
00:9944 : ad 7e a7 LDA $a77e ; (fround5[0] + 24)
00:9947 : 85 47 __ STA T1 + 0 
00:9949 : ad 7f a7 LDA $a77f ; (fround5[0] + 25)
00:994c : 85 48 __ STA T1 + 1 
00:994e : ad 80 a7 LDA $a780 ; (fround5[0] + 26)
00:9951 : 85 49 __ STA T1 + 2 
00:9953 : ad 81 a7 LDA $a781 ; (fround5[0] + 27)
00:9956 : b0 15 __ BCS $996d ; (nformf.s55 + 0)
.s62:
00:9958 : 0a __ __ ASL
00:9959 : 0a __ __ ASL
00:995a : aa __ __ TAX
00:995b : bd 62 a7 LDA $a762,x ; (current_page + 0)
00:995e : 85 47 __ STA T1 + 0 
00:9960 : bd 63 a7 LDA $a763,x ; (current_page + 1)
00:9963 : 85 48 __ STA T1 + 1 
00:9965 : bd 64 a7 LDA $a764,x ; (search_query_len + 0)
00:9968 : 85 49 __ STA T1 + 2 
00:996a : bd 65 a7 LDA $a765,x ; (search_query_len + 1)
.s55:
00:996d : 85 4a __ STA T1 + 3 
00:996f : a2 47 __ LDX #$47
00:9971 : 20 09 a7 JSR $a709 ; (freg@proxy + 0)
00:9974 : 20 84 a0 JSR $a084 ; (faddsub + 6)
00:9977 : a5 1c __ LDA ACCU + 1 
00:9979 : 85 12 __ STA P5 ; (f + 1)
00:997b : a5 1d __ LDA ACCU + 2 
00:997d : 85 13 __ STA P6 ; (f + 2)
00:997f : a6 1b __ LDX ACCU + 0 
00:9981 : a5 1e __ LDA ACCU + 3 
00:9983 : 85 14 __ STA P7 ; (f + 3)
00:9985 : 10 03 __ BPL $998a ; (nformf.s57 + 0)
00:9987 : 4c a3 97 JMP $97a3 ; (nformf.s18 + 0)
.s57:
00:998a : c9 41 __ CMP #$41
00:998c : d0 0d __ BNE $999b ; (nformf.s61 + 0)
.s58:
00:998e : a5 13 __ LDA P6 ; (f + 2)
00:9990 : c9 20 __ CMP #$20
00:9992 : d0 07 __ BNE $999b ; (nformf.s61 + 0)
.s59:
00:9994 : a5 12 __ LDA P5 ; (f + 1)
00:9996 : d0 03 __ BNE $999b ; (nformf.s61 + 0)
.s60:
00:9998 : 8a __ __ TXA
00:9999 : f0 02 __ BEQ $999d ; (nformf.s56 + 0)
.s61:
00:999b : 90 ea __ BCC $9987 ; (nformf.s55 + 26)
.s56:
00:999d : a9 00 __ LDA #$00
00:999f : 85 03 __ STA WORK + 0 
00:99a1 : 85 04 __ STA WORK + 1 
00:99a3 : 20 fe a6 JSR $a6fe ; (freg@proxy + 0)
00:99a6 : 20 33 a2 JSR $a233 ; (crt_fdiv + 0)
00:99a9 : a5 1c __ LDA ACCU + 1 
00:99ab : 85 12 __ STA P5 ; (f + 1)
00:99ad : a5 1d __ LDA ACCU + 2 
00:99af : 85 13 __ STA P6 ; (f + 2)
00:99b1 : a5 1e __ LDA ACCU + 3 
00:99b3 : 85 14 __ STA P7 ; (f + 3)
00:99b5 : a6 1b __ LDX ACCU + 0 
00:99b7 : e6 4d __ INC T5 + 0 
00:99b9 : d0 cc __ BNE $9987 ; (nformf.s55 + 26)
.s115:
00:99bb : e6 4e __ INC T5 + 1 
00:99bd : 4c a3 97 JMP $97a3 ; (nformf.s18 + 0)
--------------------------------------------------------------------
00:99c0 : __ __ __ BYT 25 64 2d 25 64 20 6f 66 20 25 64 00             : %d-%d of %d.
--------------------------------------------------------------------
00:99cc : __ __ __ BYT 77 2f 73 3a 6d 6f 76 65 20 65 6e 74 65 72 3a 73 : w/s:move enter:s
00:99dc : __ __ __ BYT 65 6c 20 2f 3a 73 65 61 72 63 68 20 71 3a 71 75 : el /:search q:qu
00:99ec : __ __ __ BYT 69 74 00                                        : it.
--------------------------------------------------------------------
00:99ef : __ __ __ BYT 6b 3d 25 30 32 78 20 63 3d 25 30 32 78 00       : k=%02x c=%02x.
--------------------------------------------------------------------
00:99fd : __ __ __ BYT 20 00                                           :  .
--------------------------------------------------------------------
uci_target:
00:99ff : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
00:9a00 : __ __ __ BYT 77 2f 73 3a 6d 6f 76 65 20 65 6e 74 65 72 3a 72 : w/s:move enter:r
00:9a10 : __ __ __ BYT 75 6e 20 64 65 6c 3a 62 61 63 6b 20 6e 2f 70 3a : un del:back n/p:
00:9a20 : __ __ __ BYT 70 61 67 65 00                                  : page.
--------------------------------------------------------------------
00:9a25 : __ __ __ BYT 74 79 70 65 20 74 6f 20 73 65 61 72 63 68 20 65 : type to search e
00:9a35 : __ __ __ BYT 6e 74 65 72 3a 72 75 6e 20 64 65 6c 3a 62 61 63 : nter:run del:bac
00:9a45 : __ __ __ BYT 6b 00                                           : k.
--------------------------------------------------------------------
00:9a47 : __ __ __ BYT 61 73 73 65 6d 62 6c 79 36 34 20 2d 20 63 61 74 : assembly64 - cat
00:9a57 : __ __ __ BYT 65 67 6f 72 69 65 73 00                         : egories.
--------------------------------------------------------------------
get_key: ; get_key()->u8
; 355, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
00:9a5f : a5 53 __ LDA T1 + 0 
00:9a61 : 8d b5 46 STA $46b5 ; (get_key@stack + 0)
00:9a64 : a5 54 __ LDA T3 + 0 
00:9a66 : 8d b6 46 STA $46b6 ; (get_key@stack + 1)
.s4:
00:9a69 : 20 7e 86 JSR $867e ; (keyb_poll.s4 + 0)
00:9a6c : ad 00 11 LDA $1100 ; (keyb_key + 0)
00:9a6f : 30 03 __ BMI $9a74 ; (get_key.s5 + 0)
00:9a71 : 4c 0a 9b JMP $9b0a ; (get_key.s49 + 0)
.s5:
00:9a74 : 29 40 __ AND #$40
00:9a76 : f0 02 __ BEQ $9a7a ; (get_key.s46 + 0)
.s45:
00:9a78 : a9 01 __ LDA #$01
.s46:
00:9a7a : 85 54 __ STA T3 + 0 
00:9a7c : 8d fe 46 STA $46fe ; (sstack + 8)
00:9a7f : ad 00 11 LDA $1100 ; (keyb_key + 0)
00:9a82 : 29 3f __ AND #$3f
00:9a84 : 85 53 __ STA T1 + 0 
00:9a86 : 85 18 __ STA P11 
00:9a88 : 20 8d 84 JSR $848d ; (debug_key.s4 + 0)
00:9a8b : a5 53 __ LDA T1 + 0 
00:9a8d : c9 01 __ CMP #$01
00:9a8f : d0 0f __ BNE $9aa0 ; (get_key.s6 + 0)
.s44:
00:9a91 : a9 0d __ LDA #$0d
.s3:
00:9a93 : 85 1b __ STA ACCU + 0 
00:9a95 : ad b5 46 LDA $46b5 ; (get_key@stack + 0)
00:9a98 : 85 53 __ STA T1 + 0 
00:9a9a : ad b6 46 LDA $46b6 ; (get_key@stack + 1)
00:9a9d : 85 54 __ STA T3 + 0 
00:9a9f : 60 __ __ RTS
.s6:
00:9aa0 : aa __ __ TAX
00:9aa1 : f0 27 __ BEQ $9aca ; (get_key.s50 + 0)
.s7:
00:9aa3 : ad 62 a7 LDA $a762 ; (current_page + 0)
00:9aa6 : 0d 63 a7 ORA $a763 ; (current_page + 1)
00:9aa9 : d0 03 __ BNE $9aae ; (get_key.s8 + 0)
00:9aab : 4c 47 9b JMP $9b47 ; (get_key.s35 + 0)
.s8:
00:9aae : ad 63 a7 LDA $a763 ; (current_page + 1)
00:9ab1 : d0 57 __ BNE $9b0a ; (get_key.s49 + 0)
.s34:
00:9ab3 : ae 62 a7 LDX $a762 ; (current_page + 0)
00:9ab6 : ca __ __ DEX
00:9ab7 : f0 63 __ BEQ $9b1c ; (get_key.s25 + 0)
.s24:
00:9ab9 : ad 62 a7 LDA $a762 ; (current_page + 0)
00:9abc : c9 02 __ CMP #$02
00:9abe : d0 4a __ BNE $9b0a ; (get_key.s49 + 0)
.s9:
00:9ac0 : a5 53 __ LDA T1 + 0 
00:9ac2 : c9 02 __ CMP #$02
00:9ac4 : d0 08 __ BNE $9ace ; (get_key.s10 + 0)
.s23:
00:9ac6 : a5 54 __ LDA T3 + 0 
00:9ac8 : f0 04 __ BEQ $9ace ; (get_key.s10 + 0)
.s50:
00:9aca : a9 08 __ LDA #$08
00:9acc : d0 c5 __ BNE $9a93 ; (get_key.s3 + 0)
.s10:
00:9ace : ad 5b a7 LDA $a75b ; (item_count + 1)
00:9ad1 : 30 0b __ BMI $9ade ; (get_key.s11 + 0)
.s22:
00:9ad3 : 0d 5a a7 ORA $a75a ; (item_count + 0)
00:9ad6 : f0 06 __ BEQ $9ade ; (get_key.s11 + 0)
.s20:
00:9ad8 : a5 53 __ LDA T1 + 0 
00:9ada : c9 07 __ CMP #$07
00:9adc : f0 30 __ BEQ $9b0e ; (get_key.s21 + 0)
.s11:
00:9ade : a5 54 __ LDA T3 + 0 
00:9ae0 : f0 06 __ BEQ $9ae8 ; (get_key.s12 + 0)
.s19:
00:9ae2 : a5 53 __ LDA T1 + 0 
00:9ae4 : 09 40 __ ORA #$40
00:9ae6 : 85 53 __ STA T1 + 0 
.s12:
00:9ae8 : a6 53 __ LDX T1 + 0 
00:9aea : bd 00 a8 LDA $a800,x ; (keyb_codes[0] + 0)
00:9aed : c9 61 __ CMP #$61
00:9aef : 90 09 __ BCC $9afa ; (get_key.s13 + 0)
.s17:
00:9af1 : c9 7b __ CMP #$7b
00:9af3 : b0 05 __ BCS $9afa ; (get_key.s13 + 0)
.s18:
00:9af5 : e9 1f __ SBC #$1f
00:9af7 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s13:
00:9afa : c9 41 __ CMP #$41
00:9afc : 90 04 __ BCC $9b02 ; (get_key.s14 + 0)
.s16:
00:9afe : c9 5b __ CMP #$5b
00:9b00 : 90 91 __ BCC $9a93 ; (get_key.s3 + 0)
.s14:
00:9b02 : c9 30 __ CMP #$30
00:9b04 : 90 04 __ BCC $9b0a ; (get_key.s49 + 0)
.s15:
00:9b06 : c9 3a __ CMP #$3a
00:9b08 : 90 89 __ BCC $9a93 ; (get_key.s3 + 0)
.s49:
00:9b0a : a9 00 __ LDA #$00
00:9b0c : f0 85 __ BEQ $9a93 ; (get_key.s3 + 0)
.s21:
00:9b0e : a5 54 __ LDA T3 + 0 
00:9b10 : f0 05 __ BEQ $9b17 ; (get_key.s47 + 0)
.s51:
00:9b12 : a9 75 __ LDA #$75
00:9b14 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s47:
00:9b17 : a9 64 __ LDA #$64
00:9b19 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s25:
00:9b1c : a5 53 __ LDA T1 + 0 
00:9b1e : c9 09 __ CMP #$09
00:9b20 : f0 f0 __ BEQ $9b12 ; (get_key.s51 + 0)
.s26:
00:9b22 : c9 07 __ CMP #$07
00:9b24 : f0 e8 __ BEQ $9b0e ; (get_key.s21 + 0)
.s27:
00:9b26 : c9 0d __ CMP #$0d
00:9b28 : f0 ed __ BEQ $9b17 ; (get_key.s47 + 0)
.s28:
00:9b2a : c9 27 __ CMP #$27
00:9b2c : d0 05 __ BNE $9b33 ; (get_key.s29 + 0)
.s33:
00:9b2e : a9 6e __ LDA #$6e
00:9b30 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s29:
00:9b33 : c9 29 __ CMP #$29
00:9b35 : d0 05 __ BNE $9b3c ; (get_key.s30 + 0)
.s32:
00:9b37 : a9 70 __ LDA #$70
00:9b39 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s30:
00:9b3c : c9 02 __ CMP #$02
00:9b3e : d0 ca __ BNE $9b0a ; (get_key.s49 + 0)
.s31:
00:9b40 : a5 54 __ LDA T3 + 0 
00:9b42 : d0 86 __ BNE $9aca ; (get_key.s50 + 0)
00:9b44 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s35:
00:9b47 : a5 53 __ LDA T1 + 0 
00:9b49 : c9 3e __ CMP #$3e
00:9b4b : d0 05 __ BNE $9b52 ; (get_key.s36 + 0)
.s43:
00:9b4d : a9 71 __ LDA #$71
00:9b4f : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s36:
00:9b52 : c9 09 __ CMP #$09
00:9b54 : f0 bc __ BEQ $9b12 ; (get_key.s51 + 0)
.s37:
00:9b56 : c9 07 __ CMP #$07
00:9b58 : f0 b4 __ BEQ $9b0e ; (get_key.s21 + 0)
.s38:
00:9b5a : c9 0d __ CMP #$0d
00:9b5c : f0 b9 __ BEQ $9b17 ; (get_key.s47 + 0)
.s39:
00:9b5e : c9 37 __ CMP #$37
00:9b60 : d0 05 __ BNE $9b67 ; (get_key.s40 + 0)
.s42:
00:9b62 : a9 2f __ LDA #$2f
00:9b64 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
.s40:
00:9b67 : c9 02 __ CMP #$02
00:9b69 : d0 9f __ BNE $9b0a ; (get_key.s49 + 0)
.s41:
00:9b6b : a5 54 __ LDA T3 + 0 
00:9b6d : d0 9b __ BNE $9b0a ; (get_key.s49 + 0)
.s48:
00:9b6f : a9 3e __ LDA #$3e
00:9b71 : 4c 93 9a JMP $9a93 ; (get_key.s3 + 0)
--------------------------------------------------------------------
00:9b74 : __ __ __ BYT 61 73 73 65 6d 62 6c 79 36 34 20 2d 20 73 65 61 : assembly64 - sea
00:9b84 : __ __ __ BYT 72 63 68 00                                     : rch.
--------------------------------------------------------------------
update_cursor: ; update_cursor(i16,i16)->void
; 454, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:9b88 : 24 18 __ BIT P11 ; (old_cursor + 1)
00:9b8a : 30 20 __ BMI $9bac ; (update_cursor.s5 + 0)
.s11:
00:9b8c : 2c 5b a7 BIT $a75b ; (item_count + 1)
00:9b8f : 30 1b __ BMI $9bac ; (update_cursor.s5 + 0)
.s15:
00:9b91 : a5 18 __ LDA P11 ; (old_cursor + 1)
00:9b93 : cd 5b a7 CMP $a75b ; (item_count + 1)
00:9b96 : d0 40 __ BNE $9bd8 ; (update_cursor.s14 + 0)
.s13:
00:9b98 : a5 17 __ LDA P10 ; (old_cursor + 0)
00:9b9a : cd 5a a7 CMP $a75a ; (item_count + 0)
00:9b9d : b0 0d __ BCS $9bac ; (update_cursor.s5 + 0)
.s12:
00:9b9f : 85 14 __ STA P7 
00:9ba1 : a5 18 __ LDA P11 ; (old_cursor + 1)
00:9ba3 : 85 15 __ STA P8 
00:9ba5 : a9 00 __ LDA #$00
00:9ba7 : 85 16 __ STA P9 
00:9ba9 : 20 72 8e JSR $8e72 ; (draw_item.s4 + 0)
.s5:
00:9bac : 2c f7 46 BIT $46f7 ; (sstack + 1)
00:9baf : 30 15 __ BMI $9bc6 ; (update_cursor.s3 + 0)
.s6:
00:9bb1 : 2c 5b a7 BIT $a75b ; (item_count + 1)
00:9bb4 : 30 10 __ BMI $9bc6 ; (update_cursor.s3 + 0)
.s10:
00:9bb6 : ad f7 46 LDA $46f7 ; (sstack + 1)
00:9bb9 : cd 5b a7 CMP $a75b ; (item_count + 1)
00:9bbc : d0 06 __ BNE $9bc4 ; (update_cursor.s9 + 0)
.s8:
00:9bbe : ad f6 46 LDA $46f6 ; (sstack + 0)
00:9bc1 : cd 5a a7 CMP $a75a ; (item_count + 0)
.s9:
00:9bc4 : 90 01 __ BCC $9bc7 ; (update_cursor.s7 + 0)
.s3:
00:9bc6 : 60 __ __ RTS
.s7:
00:9bc7 : ad f6 46 LDA $46f6 ; (sstack + 0)
00:9bca : 85 14 __ STA P7 
00:9bcc : ad f7 46 LDA $46f7 ; (sstack + 1)
00:9bcf : 85 15 __ STA P8 
00:9bd1 : a9 01 __ LDA #$01
00:9bd3 : 85 16 __ STA P9 
00:9bd5 : 4c 72 8e JMP $8e72 ; (draw_item.s4 + 0)
.s14:
00:9bd8 : b0 d2 __ BCS $9bac ; (update_cursor.s5 + 0)
.s16:
00:9bda : a5 17 __ LDA P10 ; (old_cursor + 0)
00:9bdc : 90 c1 __ BCC $9b9f ; (update_cursor.s12 + 0)
--------------------------------------------------------------------
load_entries: ; load_entries(const u8*,i16)->void
; 207, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
00:9bde : a2 07 __ LDX #$07
00:9be0 : b5 53 __ LDA T0 + 0,x 
00:9be2 : 9d 86 46 STA $4686,x ; (load_entries@stack + 0)
00:9be5 : ca __ __ DEX
00:9be6 : 10 f8 __ BPL $9be0 ; (load_entries.s1 + 2)
.s4:
00:9be8 : 20 10 88 JSR $8810 ; (clear_line@proxy + 0)
00:9beb : a9 9d __ LDA #$9d
00:9bed : 85 10 __ STA P3 
00:9bef : a9 9c __ LDA #$9c
00:9bf1 : 85 0f __ STA P2 
00:9bf3 : 20 2f 9e JSR $9e2f ; (print_at@proxy + 0)
00:9bf6 : a9 98 __ LDA #$98
00:9bf8 : 85 0d __ STA P0 
00:9bfa : a9 46 __ LDA #$46
00:9bfc : 85 0e __ STA P1 
00:9bfe : a2 ff __ LDX #$ff
.l5:
00:9c00 : e8 __ __ INX
00:9c01 : bd a7 9d LDA $9da7,x 
00:9c04 : 9d 98 46 STA $4698,x ; (cmd[0] + 0)
00:9c07 : d0 f7 __ BNE $9c00 ; (load_entries.l5 + 0)
.s6:
00:9c09 : a9 54 __ LDA #$54
00:9c0b : 85 0f __ STA P2 
00:9c0d : a9 14 __ LDA #$14
00:9c0f : 85 10 __ STA P3 
00:9c11 : 20 ad 9d JSR $9dad ; (strcat.s4 + 0)
00:9c14 : a9 fd __ LDA #$fd
00:9c16 : 85 0f __ STA P2 
00:9c18 : a9 99 __ LDA #$99
00:9c1a : 85 10 __ STA P3 
00:9c1c : 20 ad 9d JSR $9dad ; (strcat.s4 + 0)
00:9c1f : ad fe 46 LDA $46fe ; (sstack + 8)
00:9c22 : 85 57 __ STA T3 + 0 
00:9c24 : 8d f8 46 STA $46f8 ; (sstack + 2)
00:9c27 : a9 90 __ LDA #$90
00:9c29 : 85 16 __ STA P9 
00:9c2b : a9 46 __ LDA #$46
00:9c2d : 85 17 __ STA P10 
00:9c2f : a9 e0 __ LDA #$e0
00:9c31 : 8d f6 46 STA $46f6 ; (sstack + 0)
00:9c34 : a9 9d __ LDA #$9d
00:9c36 : 8d f7 46 STA $46f7 ; (sstack + 1)
00:9c39 : ad ff 46 LDA $46ff ; (sstack + 9)
00:9c3c : 85 58 __ STA T3 + 1 
00:9c3e : 8d f9 46 STA $46f9 ; (sstack + 3)
00:9c41 : 20 2d 8f JSR $8f2d ; (sprintf.s1 + 0)
00:9c44 : a9 98 __ LDA #$98
00:9c46 : 85 0d __ STA P0 
00:9c48 : a9 46 __ LDA #$46
00:9c4a : 85 10 __ STA P3 
00:9c4c : a9 46 __ LDA #$46
00:9c4e : 85 0e __ STA P1 
00:9c50 : a9 90 __ LDA #$90
00:9c52 : 85 0f __ STA P2 
00:9c54 : 20 ad 9d JSR $9dad ; (strcat.s4 + 0)
00:9c57 : a9 e3 __ LDA #$e3
00:9c59 : 85 0f __ STA P2 
00:9c5b : a9 9d __ LDA #$9d
00:9c5d : 85 10 __ STA P3 
00:9c5f : 20 ad 9d JSR $9dad ; (strcat.s4 + 0)
00:9c62 : a9 98 __ LDA #$98
00:9c64 : 85 14 __ STA P7 
00:9c66 : a9 46 __ LDA #$46
00:9c68 : 85 15 __ STA P8 
00:9c6a : 20 16 8b JSR $8b16 ; (send_command.s4 + 0)
00:9c6d : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:9c70 : 20 ec 8a JSR $8aec ; (atoi@proxy + 0)
00:9c73 : a5 1b __ LDA ACCU + 0 
00:9c75 : 85 55 __ STA T2 + 0 
00:9c77 : a5 1c __ LDA ACCU + 1 
00:9c79 : 85 56 __ STA T2 + 1 
00:9c7b : 20 1c a7 JSR $a71c ; (strchr@proxy + 0)
00:9c7e : a5 1c __ LDA ACCU + 1 
00:9c80 : 05 1b __ ORA ACCU + 0 
00:9c82 : f0 1a __ BEQ $9c9e ; (load_entries.s7 + 0)
.s24:
00:9c84 : 18 __ __ CLC
00:9c85 : a5 1b __ LDA ACCU + 0 
00:9c87 : 69 01 __ ADC #$01
00:9c89 : 85 0d __ STA P0 
00:9c8b : a5 1c __ LDA ACCU + 1 
00:9c8d : 69 00 __ ADC #$00
00:9c8f : 85 0e __ STA P1 
00:9c91 : 20 d6 8b JSR $8bd6 ; (atoi.l4 + 0)
00:9c94 : a5 1b __ LDA ACCU + 0 
00:9c96 : 8d 5c a7 STA $a75c ; (total_count + 0)
00:9c99 : a5 1c __ LDA ACCU + 1 
00:9c9b : 8d 5d a7 STA $a75d ; (total_count + 1)
.s7:
00:9c9e : a5 57 __ LDA T3 + 0 
00:9ca0 : 8d 60 a7 STA $a760 ; (offset + 0)
00:9ca3 : a5 58 __ LDA T3 + 1 
00:9ca5 : 8d 61 a7 STA $a761 ; (offset + 1)
00:9ca8 : a9 00 __ LDA #$00
00:9caa : 8d 5a a7 STA $a75a ; (item_count + 0)
00:9cad : 8d 5b a7 STA $a75b ; (item_count + 1)
00:9cb0 : a5 56 __ LDA T2 + 1 
00:9cb2 : 30 3e __ BMI $9cf2 ; (load_entries.s8 + 0)
.s23:
00:9cb4 : 05 55 __ ORA T2 + 0 
00:9cb6 : f0 3a __ BEQ $9cf2 ; (load_entries.s8 + 0)
.s11:
00:9cb8 : a9 00 __ LDA #$00
00:9cba : 85 57 __ STA T3 + 0 
.l12:
00:9cbc : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:9cbf : ad 0a 11 LDA $110a ; (line_buffer[0] + 0)
00:9cc2 : c9 2e __ CMP #$2e
00:9cc4 : f0 2c __ BEQ $9cf2 ; (load_entries.s8 + 0)
.s13:
00:9cc6 : 20 80 8c JSR $8c80 ; (strchr@proxy + 0)
00:9cc9 : a5 1c __ LDA ACCU + 1 
00:9ccb : 05 1b __ ORA ACCU + 0 
00:9ccd : d0 59 __ BNE $9d28 ; (load_entries.s20 + 0)
.s14:
00:9ccf : ad 5a a7 LDA $a75a ; (item_count + 0)
00:9cd2 : 85 57 __ STA T3 + 0 
00:9cd4 : ad 5b a7 LDA $a75b ; (item_count + 1)
00:9cd7 : 30 e3 __ BMI $9cbc ; (load_entries.l12 + 0)
.s19:
00:9cd9 : d0 17 __ BNE $9cf2 ; (load_entries.s8 + 0)
.s18:
00:9cdb : a5 57 __ LDA T3 + 0 
00:9cdd : c9 14 __ CMP #$14
00:9cdf : b0 11 __ BCS $9cf2 ; (load_entries.s8 + 0)
.s15:
00:9ce1 : ad 5b a7 LDA $a75b ; (item_count + 1)
00:9ce4 : 30 d6 __ BMI $9cbc ; (load_entries.l12 + 0)
.s17:
00:9ce6 : c5 56 __ CMP T2 + 1 
00:9ce8 : 90 d2 __ BCC $9cbc ; (load_entries.l12 + 0)
.s25:
00:9cea : d0 06 __ BNE $9cf2 ; (load_entries.s8 + 0)
.s16:
00:9cec : a5 57 __ LDA T3 + 0 
00:9cee : c5 55 __ CMP T2 + 0 
00:9cf0 : 90 ca __ BCC $9cbc ; (load_entries.l12 + 0)
.s8:
00:9cf2 : ad 0a 11 LDA $110a ; (line_buffer[0] + 0)
00:9cf5 : c9 2e __ CMP #$2e
00:9cf7 : f0 0a __ BEQ $9d03 ; (load_entries.s9 + 0)
.l10:
00:9cf9 : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:9cfc : ad 0a 11 LDA $110a ; (line_buffer[0] + 0)
00:9cff : c9 2e __ CMP #$2e
00:9d01 : d0 f6 __ BNE $9cf9 ; (load_entries.l10 + 0)
.s9:
00:9d03 : a9 00 __ LDA #$00
00:9d05 : 8d 63 a7 STA $a763 ; (current_page + 1)
00:9d08 : 8d 5e a7 STA $a75e ; (cursor + 0)
00:9d0b : 8d 5f a7 STA $a75f ; (cursor + 1)
00:9d0e : a9 18 __ LDA #$18
00:9d10 : 85 13 __ STA P6 
00:9d12 : a9 01 __ LDA #$01
00:9d14 : 8d 62 a7 STA $a762 ; (current_page + 0)
00:9d17 : 20 14 88 JSR $8814 ; (clear_line.s4 + 0)
00:9d1a : 20 d9 8a JSR $8ad9 ; (print_at@proxy + 0)
.s3:
00:9d1d : a2 07 __ LDX #$07
00:9d1f : bd 86 46 LDA $4686,x ; (load_entries@stack + 0)
00:9d22 : 95 53 __ STA T0 + 0,x 
00:9d24 : ca __ __ DEX
00:9d25 : 10 f8 __ BPL $9d1f ; (load_entries.s3 + 2)
00:9d27 : 60 __ __ RTS
.s20:
00:9d28 : a5 1c __ LDA ACCU + 1 
00:9d2a : 85 5a __ STA T4 + 1 
00:9d2c : a5 1b __ LDA ACCU + 0 
00:9d2e : 85 59 __ STA T4 + 0 
00:9d30 : a9 00 __ LDA #$00
00:9d32 : a8 __ __ TAY
00:9d33 : 91 1b __ STA (ACCU + 0),y 
00:9d35 : 20 2f a7 JSR $a72f ; (atoi@proxy + 0)
00:9d38 : a5 57 __ LDA T3 + 0 
00:9d3a : 0a __ __ ASL
00:9d3b : aa __ __ TAX
00:9d3c : a5 1b __ LDA ACCU + 0 
00:9d3e : 9d 0c 14 STA $140c,x ; (item_ids[0] + 0)
00:9d41 : a5 1c __ LDA ACCU + 1 
00:9d43 : 9d 0d 14 STA $140d,x ; (item_ids[0] + 1)
00:9d46 : 18 __ __ CLC
00:9d47 : a5 59 __ LDA T4 + 0 
00:9d49 : 69 01 __ ADC #$01
00:9d4b : 85 59 __ STA T4 + 0 
00:9d4d : 85 0d __ STA P0 
00:9d4f : a5 5a __ LDA T4 + 1 
00:9d51 : 69 00 __ ADC #$00
00:9d53 : 85 5a __ STA T4 + 1 
00:9d55 : 85 0e __ STA P1 
00:9d57 : 20 90 8c JSR $8c90 ; (strchr.l4 + 0)
00:9d5a : a5 59 __ LDA T4 + 0 
00:9d5c : 85 0f __ STA P2 
00:9d5e : a5 5a __ LDA T4 + 1 
00:9d60 : 85 10 __ STA P3 
00:9d62 : a5 1b __ LDA ACCU + 0 
00:9d64 : 05 1c __ ORA ACCU + 1 
00:9d66 : f0 05 __ BEQ $9d6d ; (load_entries.s21 + 0)
.s22:
00:9d68 : a9 00 __ LDA #$00
00:9d6a : a8 __ __ TAY
00:9d6b : 91 1b __ STA (ACCU + 0),y 
.s21:
00:9d6d : a5 57 __ LDA T3 + 0 
00:9d6f : 4a __ __ LSR
00:9d70 : 6a __ __ ROR
00:9d71 : 6a __ __ ROR
00:9d72 : aa __ __ TAX
00:9d73 : 29 c0 __ AND #$c0
00:9d75 : 6a __ __ ROR
00:9d76 : 69 8c __ ADC #$8c
00:9d78 : 85 53 __ STA T0 + 0 
00:9d7a : 85 0d __ STA P0 
00:9d7c : 8a __ __ TXA
00:9d7d : 29 1f __ AND #$1f
00:9d7f : 69 11 __ ADC #$11
00:9d81 : 85 54 __ STA T0 + 1 
00:9d83 : 85 0e __ STA P1 
00:9d85 : 20 b2 8c JSR $8cb2 ; (strncpy.s4 + 0)
00:9d88 : a9 00 __ LDA #$00
00:9d8a : a0 1f __ LDY #$1f
00:9d8c : 91 53 __ STA (T0 + 0),y 
00:9d8e : a6 57 __ LDX T3 + 0 
00:9d90 : e8 __ __ INX
00:9d91 : 8e 5a a7 STX $a75a ; (item_count + 0)
00:9d94 : a9 00 __ LDA #$00
00:9d96 : 8d 5b a7 STA $a75b ; (item_count + 1)
00:9d99 : 4c cf 9c JMP $9ccf ; (load_entries.s14 + 0)
--------------------------------------------------------------------
00:9d9c : __ __ __ BYT 6c 6f 61 64 69 6e 67 2e 2e 2e 00                : loading....
--------------------------------------------------------------------
00:9da7 : __ __ __ BYT 4c 49 53 54 20 00                               : LIST .
--------------------------------------------------------------------
strcat: ; strcat(u8*,const u8*)->void
;  14, "/usr/local/include/oscar64/string.h"
.s4:
00:9dad : a5 0d __ LDA P0 ; (dst + 0)
00:9daf : 85 1b __ STA ACCU + 0 
00:9db1 : a5 0e __ LDA P1 ; (dst + 1)
00:9db3 : 85 1c __ STA ACCU + 1 
00:9db5 : a0 00 __ LDY #$00
00:9db7 : b1 0d __ LDA (P0),y ; (dst + 0)
00:9db9 : f0 0f __ BEQ $9dca ; (strcat.s5 + 0)
.s6:
00:9dbb : 84 1b __ STY ACCU + 0 
00:9dbd : a4 0d __ LDY P0 ; (dst + 0)
.l7:
00:9dbf : c8 __ __ INY
00:9dc0 : d0 02 __ BNE $9dc4 ; (strcat.s11 + 0)
.s10:
00:9dc2 : e6 1c __ INC ACCU + 1 
.s11:
00:9dc4 : b1 1b __ LDA (ACCU + 0),y 
00:9dc6 : d0 f7 __ BNE $9dbf ; (strcat.l7 + 0)
.s8:
00:9dc8 : 84 1b __ STY ACCU + 0 
.s5:
00:9dca : a8 __ __ TAY
.l9:
00:9dcb : b1 0f __ LDA (P2),y ; (src + 0)
00:9dcd : 91 1b __ STA (ACCU + 0),y 
00:9dcf : aa __ __ TAX
00:9dd0 : e6 0f __ INC P2 ; (src + 0)
00:9dd2 : d0 02 __ BNE $9dd6 ; (strcat.s13 + 0)
.s12:
00:9dd4 : e6 10 __ INC P3 ; (src + 1)
.s13:
00:9dd6 : e6 1b __ INC ACCU + 0 
00:9dd8 : d0 02 __ BNE $9ddc ; (strcat.s15 + 0)
.s14:
00:9dda : e6 1c __ INC ACCU + 1 
.s15:
00:9ddc : 8a __ __ TXA
00:9ddd : d0 ec __ BNE $9dcb ; (strcat.l9 + 0)
.s3:
00:9ddf : 60 __ __ RTS
--------------------------------------------------------------------
00:9de0 : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
00:9de3 : __ __ __ BYT 20 32 30 00                                     :  20.
--------------------------------------------------------------------
run_entry: ; run_entry(i16)->void
; 272, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:9de7 : 20 10 88 JSR $8810 ; (clear_line@proxy + 0)
00:9dea : a9 9e __ LDA #$9e
00:9dec : 85 10 __ STA P3 
00:9dee : a9 3a __ LDA #$3a
00:9df0 : 85 0f __ STA P2 
00:9df2 : 20 2f 9e JSR $9e2f ; (print_at@proxy + 0)
00:9df5 : a9 b8 __ LDA #$b8
00:9df7 : 85 16 __ STA P9 
00:9df9 : a9 45 __ LDA #$45
00:9dfb : 8d f6 46 STA $46f6 ; (sstack + 0)
00:9dfe : a9 46 __ LDA #$46
00:9e00 : 85 17 __ STA P10 
00:9e02 : a9 9e __ LDA #$9e
00:9e04 : 8d f7 46 STA $46f7 ; (sstack + 1)
00:9e07 : ad fe 46 LDA $46fe ; (sstack + 8)
00:9e0a : 8d f8 46 STA $46f8 ; (sstack + 2)
00:9e0d : ad ff 46 LDA $46ff ; (sstack + 9)
00:9e10 : 8d f9 46 STA $46f9 ; (sstack + 3)
00:9e13 : 20 2d 8f JSR $8f2d ; (sprintf.s1 + 0)
00:9e16 : a9 b8 __ LDA #$b8
00:9e18 : 85 14 __ STA P7 
00:9e1a : a9 46 __ LDA #$46
00:9e1c : 85 15 __ STA P8 
00:9e1e : 20 16 8b JSR $8b16 ; (send_command.s4 + 0)
00:9e21 : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:9e24 : 20 10 88 JSR $8810 ; (clear_line@proxy + 0)
00:9e27 : a9 11 __ LDA #$11
00:9e29 : 85 10 __ STA P3 
00:9e2b : a9 0a __ LDA #$0a
00:9e2d : 85 0f __ STA P2 
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
00:9e2f : a9 00 __ LDA #$00
00:9e31 : 85 0d __ STA P0 
00:9e33 : a9 18 __ LDA #$18
00:9e35 : 85 0e __ STA P1 
00:9e37 : 4c dc 84 JMP $84dc ; (print_at.s4 + 0)
--------------------------------------------------------------------
00:9e3a : __ __ __ BYT 72 75 6e 6e 69 6e 67 2e 2e 2e 00                : running....
--------------------------------------------------------------------
00:9e45 : __ __ __ BYT 52 55 4e 20 25 64 00                            : RUN %d.
--------------------------------------------------------------------
do_search: ; do_search(const u8*,i16)->void
; 285, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s1:
00:9e4c : a2 06 __ LDX #$06
00:9e4e : b5 53 __ LDA T0 + 0,x 
00:9e50 : 9d 8e 46 STA $468e,x ; (do_search@stack + 0)
00:9e53 : ca __ __ DEX
00:9e54 : 10 f8 __ BPL $9e4e ; (do_search.s1 + 2)
.s4:
00:9e56 : 20 10 88 JSR $8810 ; (clear_line@proxy + 0)
00:9e59 : a9 9f __ LDA #$9f
00:9e5b : 85 10 __ STA P3 
00:9e5d : a9 c1 __ LDA #$c1
00:9e5f : 85 0f __ STA P2 
00:9e61 : 20 2f 9e JSR $9e2f ; (print_at@proxy + 0)
00:9e64 : a9 00 __ LDA #$00
00:9e66 : 8d fa 46 STA $46fa ; (sstack + 4)
00:9e69 : 8d fb 46 STA $46fb ; (sstack + 5)
00:9e6c : a9 98 __ LDA #$98
00:9e6e : 85 16 __ STA P9 
00:9e70 : a9 ce __ LDA #$ce
00:9e72 : 8d f6 46 STA $46f6 ; (sstack + 0)
00:9e75 : a9 46 __ LDA #$46
00:9e77 : 85 17 __ STA P10 
00:9e79 : a9 9f __ LDA #$9f
00:9e7b : 8d f7 46 STA $46f7 ; (sstack + 1)
00:9e7e : a9 34 __ LDA #$34
00:9e80 : 8d f8 46 STA $46f8 ; (sstack + 2)
00:9e83 : a9 14 __ LDA #$14
00:9e85 : 8d f9 46 STA $46f9 ; (sstack + 3)
00:9e88 : 20 2d 8f JSR $8f2d ; (sprintf.s1 + 0)
00:9e8b : a9 98 __ LDA #$98
00:9e8d : 85 14 __ STA P7 
00:9e8f : a9 46 __ LDA #$46
00:9e91 : 85 15 __ STA P8 
00:9e93 : 20 16 8b JSR $8b16 ; (send_command.s4 + 0)
00:9e96 : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:9e99 : 20 ec 8a JSR $8aec ; (atoi@proxy + 0)
00:9e9c : a5 1b __ LDA ACCU + 0 
00:9e9e : 85 55 __ STA T2 + 0 
00:9ea0 : a5 1c __ LDA ACCU + 1 
00:9ea2 : 85 56 __ STA T2 + 1 
00:9ea4 : 20 1c a7 JSR $a71c ; (strchr@proxy + 0)
00:9ea7 : a5 1c __ LDA ACCU + 1 
00:9ea9 : 05 1b __ ORA ACCU + 0 
00:9eab : f0 1a __ BEQ $9ec7 ; (do_search.s5 + 0)
.s22:
00:9ead : 18 __ __ CLC
00:9eae : a5 1b __ LDA ACCU + 0 
00:9eb0 : 69 01 __ ADC #$01
00:9eb2 : 85 0d __ STA P0 
00:9eb4 : a5 1c __ LDA ACCU + 1 
00:9eb6 : 69 00 __ ADC #$00
00:9eb8 : 85 0e __ STA P1 
00:9eba : 20 d6 8b JSR $8bd6 ; (atoi.l4 + 0)
00:9ebd : a5 1b __ LDA ACCU + 0 
00:9ebf : 8d 5c a7 STA $a75c ; (total_count + 0)
00:9ec2 : a5 1c __ LDA ACCU + 1 
00:9ec4 : 8d 5d a7 STA $a75d ; (total_count + 1)
.s5:
00:9ec7 : a9 00 __ LDA #$00
00:9ec9 : 8d 60 a7 STA $a760 ; (offset + 0)
00:9ecc : 8d 61 a7 STA $a761 ; (offset + 1)
00:9ecf : 8d 5a a7 STA $a75a ; (item_count + 0)
00:9ed2 : 8d 5b a7 STA $a75b ; (item_count + 1)
00:9ed5 : a5 56 __ LDA T2 + 1 
00:9ed7 : 30 3e __ BMI $9f17 ; (do_search.s6 + 0)
.s21:
00:9ed9 : 05 55 __ ORA T2 + 0 
00:9edb : f0 3a __ BEQ $9f17 ; (do_search.s6 + 0)
.s9:
00:9edd : a9 00 __ LDA #$00
00:9edf : 85 57 __ STA T3 + 0 
.l10:
00:9ee1 : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:9ee4 : ad 0a 11 LDA $110a ; (line_buffer[0] + 0)
00:9ee7 : c9 2e __ CMP #$2e
00:9ee9 : f0 2c __ BEQ $9f17 ; (do_search.s6 + 0)
.s11:
00:9eeb : 20 80 8c JSR $8c80 ; (strchr@proxy + 0)
00:9eee : a5 1c __ LDA ACCU + 1 
00:9ef0 : 05 1b __ ORA ACCU + 0 
00:9ef2 : d0 59 __ BNE $9f4d ; (do_search.s18 + 0)
.s12:
00:9ef4 : ad 5a a7 LDA $a75a ; (item_count + 0)
00:9ef7 : 85 57 __ STA T3 + 0 
00:9ef9 : ad 5b a7 LDA $a75b ; (item_count + 1)
00:9efc : 30 e3 __ BMI $9ee1 ; (do_search.l10 + 0)
.s17:
00:9efe : d0 17 __ BNE $9f17 ; (do_search.s6 + 0)
.s16:
00:9f00 : a5 57 __ LDA T3 + 0 
00:9f02 : c9 14 __ CMP #$14
00:9f04 : b0 11 __ BCS $9f17 ; (do_search.s6 + 0)
.s13:
00:9f06 : ad 5b a7 LDA $a75b ; (item_count + 1)
00:9f09 : 30 d6 __ BMI $9ee1 ; (do_search.l10 + 0)
.s15:
00:9f0b : c5 56 __ CMP T2 + 1 
00:9f0d : 90 d2 __ BCC $9ee1 ; (do_search.l10 + 0)
.s23:
00:9f0f : d0 06 __ BNE $9f17 ; (do_search.s6 + 0)
.s14:
00:9f11 : a5 57 __ LDA T3 + 0 
00:9f13 : c5 55 __ CMP T2 + 0 
00:9f15 : 90 ca __ BCC $9ee1 ; (do_search.l10 + 0)
.s6:
00:9f17 : ad 0a 11 LDA $110a ; (line_buffer[0] + 0)
00:9f1a : c9 2e __ CMP #$2e
00:9f1c : f0 0a __ BEQ $9f28 ; (do_search.s7 + 0)
.l8:
00:9f1e : 20 1d 89 JSR $891d ; (read_line.s4 + 0)
00:9f21 : ad 0a 11 LDA $110a ; (line_buffer[0] + 0)
00:9f24 : c9 2e __ CMP #$2e
00:9f26 : d0 f6 __ BNE $9f1e ; (do_search.l8 + 0)
.s7:
00:9f28 : a9 00 __ LDA #$00
00:9f2a : 8d 63 a7 STA $a763 ; (current_page + 1)
00:9f2d : 8d 5e a7 STA $a75e ; (cursor + 0)
00:9f30 : 8d 5f a7 STA $a75f ; (cursor + 1)
00:9f33 : a9 18 __ LDA #$18
00:9f35 : 85 13 __ STA P6 
00:9f37 : a9 02 __ LDA #$02
00:9f39 : 8d 62 a7 STA $a762 ; (current_page + 0)
00:9f3c : 20 14 88 JSR $8814 ; (clear_line.s4 + 0)
00:9f3f : 20 d9 8a JSR $8ad9 ; (print_at@proxy + 0)
.s3:
00:9f42 : a2 06 __ LDX #$06
00:9f44 : bd 8e 46 LDA $468e,x ; (do_search@stack + 0)
00:9f47 : 95 53 __ STA T0 + 0,x 
00:9f49 : ca __ __ DEX
00:9f4a : 10 f8 __ BPL $9f44 ; (do_search.s3 + 2)
00:9f4c : 60 __ __ RTS
.s18:
00:9f4d : a5 1c __ LDA ACCU + 1 
00:9f4f : 85 59 __ STA T4 + 1 
00:9f51 : a5 1b __ LDA ACCU + 0 
00:9f53 : 85 58 __ STA T4 + 0 
00:9f55 : a9 00 __ LDA #$00
00:9f57 : a8 __ __ TAY
00:9f58 : 91 1b __ STA (ACCU + 0),y 
00:9f5a : 20 2f a7 JSR $a72f ; (atoi@proxy + 0)
00:9f5d : a5 57 __ LDA T3 + 0 
00:9f5f : 0a __ __ ASL
00:9f60 : aa __ __ TAX
00:9f61 : a5 1b __ LDA ACCU + 0 
00:9f63 : 9d 0c 14 STA $140c,x ; (item_ids[0] + 0)
00:9f66 : a5 1c __ LDA ACCU + 1 
00:9f68 : 9d 0d 14 STA $140d,x ; (item_ids[0] + 1)
00:9f6b : 18 __ __ CLC
00:9f6c : a5 58 __ LDA T4 + 0 
00:9f6e : 69 01 __ ADC #$01
00:9f70 : 85 58 __ STA T4 + 0 
00:9f72 : 85 0d __ STA P0 
00:9f74 : a5 59 __ LDA T4 + 1 
00:9f76 : 69 00 __ ADC #$00
00:9f78 : 85 59 __ STA T4 + 1 
00:9f7a : 85 0e __ STA P1 
00:9f7c : 20 90 8c JSR $8c90 ; (strchr.l4 + 0)
00:9f7f : a5 58 __ LDA T4 + 0 
00:9f81 : 85 0f __ STA P2 
00:9f83 : a5 59 __ LDA T4 + 1 
00:9f85 : 85 10 __ STA P3 
00:9f87 : a5 1b __ LDA ACCU + 0 
00:9f89 : 05 1c __ ORA ACCU + 1 
00:9f8b : f0 05 __ BEQ $9f92 ; (do_search.s19 + 0)
.s20:
00:9f8d : a9 00 __ LDA #$00
00:9f8f : a8 __ __ TAY
00:9f90 : 91 1b __ STA (ACCU + 0),y 
.s19:
00:9f92 : a5 57 __ LDA T3 + 0 
00:9f94 : 4a __ __ LSR
00:9f95 : 6a __ __ ROR
00:9f96 : 6a __ __ ROR
00:9f97 : aa __ __ TAX
00:9f98 : 29 c0 __ AND #$c0
00:9f9a : 6a __ __ ROR
00:9f9b : 69 8c __ ADC #$8c
00:9f9d : 85 53 __ STA T0 + 0 
00:9f9f : 85 0d __ STA P0 
00:9fa1 : 8a __ __ TXA
00:9fa2 : 29 1f __ AND #$1f
00:9fa4 : 69 11 __ ADC #$11
00:9fa6 : 85 54 __ STA T0 + 1 
00:9fa8 : 85 0e __ STA P1 
00:9faa : 20 b2 8c JSR $8cb2 ; (strncpy.s4 + 0)
00:9fad : a9 00 __ LDA #$00
00:9faf : a0 1f __ LDY #$1f
00:9fb1 : 91 53 __ STA (T0 + 0),y 
00:9fb3 : a6 57 __ LDX T3 + 0 
00:9fb5 : e8 __ __ INX
00:9fb6 : 8e 5a a7 STX $a75a ; (item_count + 0)
00:9fb9 : a9 00 __ LDA #$00
00:9fbb : 8d 5b a7 STA $a75b ; (item_count + 1)
00:9fbe : 4c f4 9e JMP $9ef4 ; (do_search.s12 + 0)
--------------------------------------------------------------------
00:9fc1 : __ __ __ BYT 73 65 61 72 63 68 69 6e 67 2e 2e 2e 00          : searching....
--------------------------------------------------------------------
00:9fce : __ __ __ BYT 53 45 41 52 43 48 20 25 73 20 25 64 20 32 30 00 : SEARCH %s %d 20.
--------------------------------------------------------------------
disconnect_from_server: ; disconnect_from_server()->void
; 134, "/home/jalanara/Devel/Omat/C64U/c64uploader/c64client/src/main.c"
.s4:
00:9fde : ad 59 a7 LDA $a759 ; (connected + 0)
00:9fe1 : f0 46 __ BEQ $a029 ; (disconnect_from_server.s3 + 0)
.s5:
00:9fe3 : a9 2a __ LDA #$2a
00:9fe5 : 85 12 __ STA P5 
00:9fe7 : a9 a0 __ LDA #$a0
00:9fe9 : 85 13 __ STA P6 
00:9feb : 20 3a a7 JSR $a73a ; (uci_socket_write@proxy + 0)
00:9fee : a9 00 __ LDA #$00
00:9ff0 : 85 10 __ STA P3 
00:9ff2 : 8d f3 46 STA $46f3 ; (cmd[0] + 0)
00:9ff5 : a9 09 __ LDA #$09
00:9ff7 : 8d f4 46 STA $46f4 ; (cmd[0] + 1)
00:9ffa : a5 11 __ LDA P4 
00:9ffc : 8d f5 46 STA $46f5 ; (cmd[0] + 2)
00:9fff : ad ff 99 LDA $99ff ; (uci_target + 0)
00:a002 : 85 4a __ STA T1 + 0 
00:a004 : a9 03 __ LDA #$03
00:a006 : 85 0f __ STA P2 
00:a008 : 8d ff 99 STA $99ff ; (uci_target + 0)
00:a00b : a9 f3 __ LDA #$f3
00:a00d : 85 0d __ STA P0 
00:a00f : a9 46 __ LDA #$46
00:a011 : 85 0e __ STA P1 
00:a013 : 20 78 85 JSR $8578 ; (uci_sendcommand.s4 + 0)
00:a016 : 20 dd 85 JSR $85dd ; (uci_readdata.s4 + 0)
00:a019 : 20 06 86 JSR $8606 ; (uci_readstatus.s4 + 0)
00:a01c : 20 2f 86 JSR $862f ; (uci_accept.s4 + 0)
00:a01f : a9 00 __ LDA #$00
00:a021 : 8d 59 a7 STA $a759 ; (connected + 0)
00:a024 : a5 4a __ LDA T1 + 0 
00:a026 : 8d ff 99 STA $99ff ; (uci_target + 0)
.s3:
00:a029 : 60 __ __ RTS
--------------------------------------------------------------------
00:a02a : __ __ __ BYT 51 55 49 54 0a 00                               : QUIT..
--------------------------------------------------------------------
00:a030 : __ __ __ BYT 67 6f 6f 64 62 79 65 21 00                      : goodbye!.
--------------------------------------------------------------------
freg: ; freg
00:a039 : b1 19 __ LDA (IP + 0),y 
00:a03b : c8 __ __ INY
00:a03c : aa __ __ TAX
00:a03d : b5 00 __ LDA $00,x 
00:a03f : 85 03 __ STA WORK + 0 
00:a041 : b5 01 __ LDA $01,x 
00:a043 : 85 04 __ STA WORK + 1 
00:a045 : b5 02 __ LDA $02,x 
00:a047 : 85 05 __ STA WORK + 2 
00:a049 : b5 03 __ LDA WORK + 0,x 
00:a04b : 85 06 __ STA WORK + 3 
00:a04d : a5 05 __ LDA WORK + 2 
00:a04f : 0a __ __ ASL
00:a050 : a5 06 __ LDA WORK + 3 
00:a052 : 2a __ __ ROL
00:a053 : 85 08 __ STA WORK + 5 
00:a055 : f0 06 __ BEQ $a05d ; (freg + 36)
00:a057 : a5 05 __ LDA WORK + 2 
00:a059 : 09 80 __ ORA #$80
00:a05b : 85 05 __ STA WORK + 2 
00:a05d : a5 1d __ LDA ACCU + 2 
00:a05f : 0a __ __ ASL
00:a060 : a5 1e __ LDA ACCU + 3 
00:a062 : 2a __ __ ROL
00:a063 : 85 07 __ STA WORK + 4 
00:a065 : f0 06 __ BEQ $a06d ; (freg + 52)
00:a067 : a5 1d __ LDA ACCU + 2 
00:a069 : 09 80 __ ORA #$80
00:a06b : 85 1d __ STA ACCU + 2 
00:a06d : 60 __ __ RTS
00:a06e : 06 1e __ ASL ACCU + 3 
00:a070 : a5 07 __ LDA WORK + 4 
00:a072 : 6a __ __ ROR
00:a073 : 85 1e __ STA ACCU + 3 
00:a075 : b0 06 __ BCS $a07d ; (freg + 68)
00:a077 : a5 1d __ LDA ACCU + 2 
00:a079 : 29 7f __ AND #$7f
00:a07b : 85 1d __ STA ACCU + 2 
00:a07d : 60 __ __ RTS
--------------------------------------------------------------------
faddsub: ; faddsub
00:a07e : a5 06 __ LDA WORK + 3 
00:a080 : 49 80 __ EOR #$80
00:a082 : 85 06 __ STA WORK + 3 
00:a084 : a9 ff __ LDA #$ff
00:a086 : c5 07 __ CMP WORK + 4 
00:a088 : f0 04 __ BEQ $a08e ; (faddsub + 16)
00:a08a : c5 08 __ CMP WORK + 5 
00:a08c : d0 11 __ BNE $a09f ; (faddsub + 33)
00:a08e : a5 1e __ LDA ACCU + 3 
00:a090 : 09 7f __ ORA #$7f
00:a092 : 85 1e __ STA ACCU + 3 
00:a094 : a9 80 __ LDA #$80
00:a096 : 85 1d __ STA ACCU + 2 
00:a098 : a9 00 __ LDA #$00
00:a09a : 85 1b __ STA ACCU + 0 
00:a09c : 85 1c __ STA ACCU + 1 
00:a09e : 60 __ __ RTS
00:a09f : 38 __ __ SEC
00:a0a0 : a5 07 __ LDA WORK + 4 
00:a0a2 : e5 08 __ SBC WORK + 5 
00:a0a4 : f0 38 __ BEQ $a0de ; (faddsub + 96)
00:a0a6 : aa __ __ TAX
00:a0a7 : b0 25 __ BCS $a0ce ; (faddsub + 80)
00:a0a9 : e0 e9 __ CPX #$e9
00:a0ab : b0 0e __ BCS $a0bb ; (faddsub + 61)
00:a0ad : a5 08 __ LDA WORK + 5 
00:a0af : 85 07 __ STA WORK + 4 
00:a0b1 : a9 00 __ LDA #$00
00:a0b3 : 85 1b __ STA ACCU + 0 
00:a0b5 : 85 1c __ STA ACCU + 1 
00:a0b7 : 85 1d __ STA ACCU + 2 
00:a0b9 : f0 23 __ BEQ $a0de ; (faddsub + 96)
00:a0bb : a5 1d __ LDA ACCU + 2 
00:a0bd : 4a __ __ LSR
00:a0be : 66 1c __ ROR ACCU + 1 
00:a0c0 : 66 1b __ ROR ACCU + 0 
00:a0c2 : e8 __ __ INX
00:a0c3 : d0 f8 __ BNE $a0bd ; (faddsub + 63)
00:a0c5 : 85 1d __ STA ACCU + 2 
00:a0c7 : a5 08 __ LDA WORK + 5 
00:a0c9 : 85 07 __ STA WORK + 4 
00:a0cb : 4c de a0 JMP $a0de ; (faddsub + 96)
00:a0ce : e0 18 __ CPX #$18
00:a0d0 : b0 33 __ BCS $a105 ; (faddsub + 135)
00:a0d2 : a5 05 __ LDA WORK + 2 
00:a0d4 : 4a __ __ LSR
00:a0d5 : 66 04 __ ROR WORK + 1 
00:a0d7 : 66 03 __ ROR WORK + 0 
00:a0d9 : ca __ __ DEX
00:a0da : d0 f8 __ BNE $a0d4 ; (faddsub + 86)
00:a0dc : 85 05 __ STA WORK + 2 
00:a0de : a5 1e __ LDA ACCU + 3 
00:a0e0 : 29 80 __ AND #$80
00:a0e2 : 85 1e __ STA ACCU + 3 
00:a0e4 : 45 06 __ EOR WORK + 3 
00:a0e6 : 30 31 __ BMI $a119 ; (faddsub + 155)
00:a0e8 : 18 __ __ CLC
00:a0e9 : a5 1b __ LDA ACCU + 0 
00:a0eb : 65 03 __ ADC WORK + 0 
00:a0ed : 85 1b __ STA ACCU + 0 
00:a0ef : a5 1c __ LDA ACCU + 1 
00:a0f1 : 65 04 __ ADC WORK + 1 
00:a0f3 : 85 1c __ STA ACCU + 1 
00:a0f5 : a5 1d __ LDA ACCU + 2 
00:a0f7 : 65 05 __ ADC WORK + 2 
00:a0f9 : 85 1d __ STA ACCU + 2 
00:a0fb : 90 08 __ BCC $a105 ; (faddsub + 135)
00:a0fd : 66 1d __ ROR ACCU + 2 
00:a0ff : 66 1c __ ROR ACCU + 1 
00:a101 : 66 1b __ ROR ACCU + 0 
00:a103 : e6 07 __ INC WORK + 4 
00:a105 : a5 07 __ LDA WORK + 4 
00:a107 : c9 ff __ CMP #$ff
00:a109 : f0 83 __ BEQ $a08e ; (faddsub + 16)
00:a10b : 4a __ __ LSR
00:a10c : 05 1e __ ORA ACCU + 3 
00:a10e : 85 1e __ STA ACCU + 3 
00:a110 : b0 06 __ BCS $a118 ; (faddsub + 154)
00:a112 : a5 1d __ LDA ACCU + 2 
00:a114 : 29 7f __ AND #$7f
00:a116 : 85 1d __ STA ACCU + 2 
00:a118 : 60 __ __ RTS
00:a119 : 38 __ __ SEC
00:a11a : a5 1b __ LDA ACCU + 0 
00:a11c : e5 03 __ SBC WORK + 0 
00:a11e : 85 1b __ STA ACCU + 0 
00:a120 : a5 1c __ LDA ACCU + 1 
00:a122 : e5 04 __ SBC WORK + 1 
00:a124 : 85 1c __ STA ACCU + 1 
00:a126 : a5 1d __ LDA ACCU + 2 
00:a128 : e5 05 __ SBC WORK + 2 
00:a12a : 85 1d __ STA ACCU + 2 
00:a12c : b0 19 __ BCS $a147 ; (faddsub + 201)
00:a12e : 38 __ __ SEC
00:a12f : a9 00 __ LDA #$00
00:a131 : e5 1b __ SBC ACCU + 0 
00:a133 : 85 1b __ STA ACCU + 0 
00:a135 : a9 00 __ LDA #$00
00:a137 : e5 1c __ SBC ACCU + 1 
00:a139 : 85 1c __ STA ACCU + 1 
00:a13b : a9 00 __ LDA #$00
00:a13d : e5 1d __ SBC ACCU + 2 
00:a13f : 85 1d __ STA ACCU + 2 
00:a141 : a5 1e __ LDA ACCU + 3 
00:a143 : 49 80 __ EOR #$80
00:a145 : 85 1e __ STA ACCU + 3 
00:a147 : a5 1d __ LDA ACCU + 2 
00:a149 : 30 ba __ BMI $a105 ; (faddsub + 135)
00:a14b : 05 1c __ ORA ACCU + 1 
00:a14d : 05 1b __ ORA ACCU + 0 
00:a14f : f0 0f __ BEQ $a160 ; (faddsub + 226)
00:a151 : c6 07 __ DEC WORK + 4 
00:a153 : f0 0b __ BEQ $a160 ; (faddsub + 226)
00:a155 : 06 1b __ ASL ACCU + 0 
00:a157 : 26 1c __ ROL ACCU + 1 
00:a159 : 26 1d __ ROL ACCU + 2 
00:a15b : 10 f4 __ BPL $a151 ; (faddsub + 211)
00:a15d : 4c 05 a1 JMP $a105 ; (faddsub + 135)
00:a160 : a9 00 __ LDA #$00
00:a162 : 85 1b __ STA ACCU + 0 
00:a164 : 85 1c __ STA ACCU + 1 
00:a166 : 85 1d __ STA ACCU + 2 
00:a168 : 85 1e __ STA ACCU + 3 
00:a16a : 60 __ __ RTS
--------------------------------------------------------------------
crt_fmul: ; crt_fmul
00:a16b : a5 1b __ LDA ACCU + 0 
00:a16d : 05 1c __ ORA ACCU + 1 
00:a16f : 05 1d __ ORA ACCU + 2 
00:a171 : f0 0e __ BEQ $a181 ; (crt_fmul + 22)
00:a173 : a5 03 __ LDA WORK + 0 
00:a175 : 05 04 __ ORA WORK + 1 
00:a177 : 05 05 __ ORA WORK + 2 
00:a179 : d0 09 __ BNE $a184 ; (crt_fmul + 25)
00:a17b : 85 1b __ STA ACCU + 0 
00:a17d : 85 1c __ STA ACCU + 1 
00:a17f : 85 1d __ STA ACCU + 2 
00:a181 : 85 1e __ STA ACCU + 3 
00:a183 : 60 __ __ RTS
00:a184 : a5 1e __ LDA ACCU + 3 
00:a186 : 45 06 __ EOR WORK + 3 
00:a188 : 29 80 __ AND #$80
00:a18a : 85 1e __ STA ACCU + 3 
00:a18c : a9 ff __ LDA #$ff
00:a18e : c5 07 __ CMP WORK + 4 
00:a190 : f0 42 __ BEQ $a1d4 ; (crt_fmul + 105)
00:a192 : c5 08 __ CMP WORK + 5 
00:a194 : f0 3e __ BEQ $a1d4 ; (crt_fmul + 105)
00:a196 : a9 00 __ LDA #$00
00:a198 : 85 09 __ STA WORK + 6 
00:a19a : 85 0a __ STA WORK + 7 
00:a19c : 85 0b __ STA WORK + 8 
00:a19e : a4 1b __ LDY ACCU + 0 
00:a1a0 : a5 03 __ LDA WORK + 0 
00:a1a2 : d0 06 __ BNE $a1aa ; (crt_fmul + 63)
00:a1a4 : a5 04 __ LDA WORK + 1 
00:a1a6 : f0 0a __ BEQ $a1b2 ; (crt_fmul + 71)
00:a1a8 : d0 05 __ BNE $a1af ; (crt_fmul + 68)
00:a1aa : 20 05 a2 JSR $a205 ; (crt_fmul8 + 0)
00:a1ad : a5 04 __ LDA WORK + 1 
00:a1af : 20 05 a2 JSR $a205 ; (crt_fmul8 + 0)
00:a1b2 : a5 05 __ LDA WORK + 2 
00:a1b4 : 20 05 a2 JSR $a205 ; (crt_fmul8 + 0)
00:a1b7 : 38 __ __ SEC
00:a1b8 : a5 0b __ LDA WORK + 8 
00:a1ba : 30 06 __ BMI $a1c2 ; (crt_fmul + 87)
00:a1bc : 06 09 __ ASL WORK + 6 
00:a1be : 26 0a __ ROL WORK + 7 
00:a1c0 : 2a __ __ ROL
00:a1c1 : 18 __ __ CLC
00:a1c2 : 29 7f __ AND #$7f
00:a1c4 : 85 0b __ STA WORK + 8 
00:a1c6 : a5 07 __ LDA WORK + 4 
00:a1c8 : 65 08 __ ADC WORK + 5 
00:a1ca : 90 19 __ BCC $a1e5 ; (crt_fmul + 122)
00:a1cc : e9 7f __ SBC #$7f
00:a1ce : b0 04 __ BCS $a1d4 ; (crt_fmul + 105)
00:a1d0 : c9 ff __ CMP #$ff
00:a1d2 : d0 15 __ BNE $a1e9 ; (crt_fmul + 126)
00:a1d4 : a5 1e __ LDA ACCU + 3 
00:a1d6 : 09 7f __ ORA #$7f
00:a1d8 : 85 1e __ STA ACCU + 3 
00:a1da : a9 80 __ LDA #$80
00:a1dc : 85 1d __ STA ACCU + 2 
00:a1de : a9 00 __ LDA #$00
00:a1e0 : 85 1b __ STA ACCU + 0 
00:a1e2 : 85 1c __ STA ACCU + 1 
00:a1e4 : 60 __ __ RTS
00:a1e5 : e9 7e __ SBC #$7e
00:a1e7 : 90 15 __ BCC $a1fe ; (crt_fmul + 147)
00:a1e9 : 4a __ __ LSR
00:a1ea : 05 1e __ ORA ACCU + 3 
00:a1ec : 85 1e __ STA ACCU + 3 
00:a1ee : a9 00 __ LDA #$00
00:a1f0 : 6a __ __ ROR
00:a1f1 : 05 0b __ ORA WORK + 8 
00:a1f3 : 85 1d __ STA ACCU + 2 
00:a1f5 : a5 0a __ LDA WORK + 7 
00:a1f7 : 85 1c __ STA ACCU + 1 
00:a1f9 : a5 09 __ LDA WORK + 6 
00:a1fb : 85 1b __ STA ACCU + 0 
00:a1fd : 60 __ __ RTS
00:a1fe : a9 00 __ LDA #$00
00:a200 : 85 1e __ STA ACCU + 3 
00:a202 : f0 d8 __ BEQ $a1dc ; (crt_fmul + 113)
00:a204 : 60 __ __ RTS
--------------------------------------------------------------------
crt_fmul8: ; crt_fmul8
00:a205 : 38 __ __ SEC
00:a206 : 6a __ __ ROR
00:a207 : 90 1e __ BCC $a227 ; (crt_fmul8 + 34)
00:a209 : aa __ __ TAX
00:a20a : 18 __ __ CLC
00:a20b : 98 __ __ TYA
00:a20c : 65 09 __ ADC WORK + 6 
00:a20e : 85 09 __ STA WORK + 6 
00:a210 : a5 0a __ LDA WORK + 7 
00:a212 : 65 1c __ ADC ACCU + 1 
00:a214 : 85 0a __ STA WORK + 7 
00:a216 : a5 0b __ LDA WORK + 8 
00:a218 : 65 1d __ ADC ACCU + 2 
00:a21a : 6a __ __ ROR
00:a21b : 85 0b __ STA WORK + 8 
00:a21d : 8a __ __ TXA
00:a21e : 66 0a __ ROR WORK + 7 
00:a220 : 66 09 __ ROR WORK + 6 
00:a222 : 4a __ __ LSR
00:a223 : f0 0d __ BEQ $a232 ; (crt_fmul8 + 45)
00:a225 : b0 e2 __ BCS $a209 ; (crt_fmul8 + 4)
00:a227 : 66 0b __ ROR WORK + 8 
00:a229 : 66 0a __ ROR WORK + 7 
00:a22b : 66 09 __ ROR WORK + 6 
00:a22d : 4a __ __ LSR
00:a22e : 90 f7 __ BCC $a227 ; (crt_fmul8 + 34)
00:a230 : d0 d7 __ BNE $a209 ; (crt_fmul8 + 4)
00:a232 : 60 __ __ RTS
--------------------------------------------------------------------
crt_fdiv: ; crt_fdiv
00:a233 : a5 1b __ LDA ACCU + 0 
00:a235 : 05 1c __ ORA ACCU + 1 
00:a237 : 05 1d __ ORA ACCU + 2 
00:a239 : d0 03 __ BNE $a23e ; (crt_fdiv + 11)
00:a23b : 85 1e __ STA ACCU + 3 
00:a23d : 60 __ __ RTS
00:a23e : a5 1e __ LDA ACCU + 3 
00:a240 : 45 06 __ EOR WORK + 3 
00:a242 : 29 80 __ AND #$80
00:a244 : 85 1e __ STA ACCU + 3 
00:a246 : a5 08 __ LDA WORK + 5 
00:a248 : f0 62 __ BEQ $a2ac ; (crt_fdiv + 121)
00:a24a : a5 07 __ LDA WORK + 4 
00:a24c : c9 ff __ CMP #$ff
00:a24e : f0 5c __ BEQ $a2ac ; (crt_fdiv + 121)
00:a250 : a9 00 __ LDA #$00
00:a252 : 85 09 __ STA WORK + 6 
00:a254 : 85 0a __ STA WORK + 7 
00:a256 : 85 0b __ STA WORK + 8 
00:a258 : a2 18 __ LDX #$18
00:a25a : a5 1b __ LDA ACCU + 0 
00:a25c : c5 03 __ CMP WORK + 0 
00:a25e : a5 1c __ LDA ACCU + 1 
00:a260 : e5 04 __ SBC WORK + 1 
00:a262 : a5 1d __ LDA ACCU + 2 
00:a264 : e5 05 __ SBC WORK + 2 
00:a266 : 90 13 __ BCC $a27b ; (crt_fdiv + 72)
00:a268 : a5 1b __ LDA ACCU + 0 
00:a26a : e5 03 __ SBC WORK + 0 
00:a26c : 85 1b __ STA ACCU + 0 
00:a26e : a5 1c __ LDA ACCU + 1 
00:a270 : e5 04 __ SBC WORK + 1 
00:a272 : 85 1c __ STA ACCU + 1 
00:a274 : a5 1d __ LDA ACCU + 2 
00:a276 : e5 05 __ SBC WORK + 2 
00:a278 : 85 1d __ STA ACCU + 2 
00:a27a : 38 __ __ SEC
00:a27b : 26 09 __ ROL WORK + 6 
00:a27d : 26 0a __ ROL WORK + 7 
00:a27f : 26 0b __ ROL WORK + 8 
00:a281 : ca __ __ DEX
00:a282 : f0 0a __ BEQ $a28e ; (crt_fdiv + 91)
00:a284 : 06 1b __ ASL ACCU + 0 
00:a286 : 26 1c __ ROL ACCU + 1 
00:a288 : 26 1d __ ROL ACCU + 2 
00:a28a : b0 dc __ BCS $a268 ; (crt_fdiv + 53)
00:a28c : 90 cc __ BCC $a25a ; (crt_fdiv + 39)
00:a28e : 38 __ __ SEC
00:a28f : a5 0b __ LDA WORK + 8 
00:a291 : 30 06 __ BMI $a299 ; (crt_fdiv + 102)
00:a293 : 06 09 __ ASL WORK + 6 
00:a295 : 26 0a __ ROL WORK + 7 
00:a297 : 2a __ __ ROL
00:a298 : 18 __ __ CLC
00:a299 : 29 7f __ AND #$7f
00:a29b : 85 0b __ STA WORK + 8 
00:a29d : a5 07 __ LDA WORK + 4 
00:a29f : e5 08 __ SBC WORK + 5 
00:a2a1 : 90 1a __ BCC $a2bd ; (crt_fdiv + 138)
00:a2a3 : 18 __ __ CLC
00:a2a4 : 69 7f __ ADC #$7f
00:a2a6 : b0 04 __ BCS $a2ac ; (crt_fdiv + 121)
00:a2a8 : c9 ff __ CMP #$ff
00:a2aa : d0 15 __ BNE $a2c1 ; (crt_fdiv + 142)
00:a2ac : a5 1e __ LDA ACCU + 3 
00:a2ae : 09 7f __ ORA #$7f
00:a2b0 : 85 1e __ STA ACCU + 3 
00:a2b2 : a9 80 __ LDA #$80
00:a2b4 : 85 1d __ STA ACCU + 2 
00:a2b6 : a9 00 __ LDA #$00
00:a2b8 : 85 1c __ STA ACCU + 1 
00:a2ba : 85 1b __ STA ACCU + 0 
00:a2bc : 60 __ __ RTS
00:a2bd : 69 7f __ ADC #$7f
00:a2bf : 90 15 __ BCC $a2d6 ; (crt_fdiv + 163)
00:a2c1 : 4a __ __ LSR
00:a2c2 : 05 1e __ ORA ACCU + 3 
00:a2c4 : 85 1e __ STA ACCU + 3 
00:a2c6 : a9 00 __ LDA #$00
00:a2c8 : 6a __ __ ROR
00:a2c9 : 05 0b __ ORA WORK + 8 
00:a2cb : 85 1d __ STA ACCU + 2 
00:a2cd : a5 0a __ LDA WORK + 7 
00:a2cf : 85 1c __ STA ACCU + 1 
00:a2d1 : a5 09 __ LDA WORK + 6 
00:a2d3 : 85 1b __ STA ACCU + 0 
00:a2d5 : 60 __ __ RTS
00:a2d6 : a9 00 __ LDA #$00
00:a2d8 : 85 1e __ STA ACCU + 3 
00:a2da : 85 1d __ STA ACCU + 2 
00:a2dc : 85 1c __ STA ACCU + 1 
00:a2de : 85 1b __ STA ACCU + 0 
00:a2e0 : 60 __ __ RTS
--------------------------------------------------------------------
divs16: ; divs16
00:a2e1 : 24 1c __ BIT ACCU + 1 
00:a2e3 : 10 0d __ BPL $a2f2 ; (divs16 + 17)
00:a2e5 : 20 fc a2 JSR $a2fc ; (negaccu + 0)
00:a2e8 : 24 04 __ BIT WORK + 1 
00:a2ea : 10 0d __ BPL $a2f9 ; (divs16 + 24)
00:a2ec : 20 0a a3 JSR $a30a ; (negtmp + 0)
00:a2ef : 4c 18 a3 JMP $a318 ; (divmod + 0)
00:a2f2 : 24 04 __ BIT WORK + 1 
00:a2f4 : 10 f9 __ BPL $a2ef ; (divs16 + 14)
00:a2f6 : 20 0a a3 JSR $a30a ; (negtmp + 0)
00:a2f9 : 20 18 a3 JSR $a318 ; (divmod + 0)
--------------------------------------------------------------------
negaccu: ; negaccu
00:a2fc : 38 __ __ SEC
00:a2fd : a9 00 __ LDA #$00
00:a2ff : e5 1b __ SBC ACCU + 0 
00:a301 : 85 1b __ STA ACCU + 0 
00:a303 : a9 00 __ LDA #$00
00:a305 : e5 1c __ SBC ACCU + 1 
00:a307 : 85 1c __ STA ACCU + 1 
00:a309 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp: ; negtmp
00:a30a : 38 __ __ SEC
00:a30b : a9 00 __ LDA #$00
00:a30d : e5 03 __ SBC WORK + 0 
00:a30f : 85 03 __ STA WORK + 0 
00:a311 : a9 00 __ LDA #$00
00:a313 : e5 04 __ SBC WORK + 1 
00:a315 : 85 04 __ STA WORK + 1 
00:a317 : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
00:a318 : a5 1c __ LDA ACCU + 1 
00:a31a : d0 31 __ BNE $a34d ; (divmod + 53)
00:a31c : a5 04 __ LDA WORK + 1 
00:a31e : d0 1e __ BNE $a33e ; (divmod + 38)
00:a320 : 85 06 __ STA WORK + 3 
00:a322 : a2 04 __ LDX #$04
00:a324 : 06 1b __ ASL ACCU + 0 
00:a326 : 2a __ __ ROL
00:a327 : c5 03 __ CMP WORK + 0 
00:a329 : 90 02 __ BCC $a32d ; (divmod + 21)
00:a32b : e5 03 __ SBC WORK + 0 
00:a32d : 26 1b __ ROL ACCU + 0 
00:a32f : 2a __ __ ROL
00:a330 : c5 03 __ CMP WORK + 0 
00:a332 : 90 02 __ BCC $a336 ; (divmod + 30)
00:a334 : e5 03 __ SBC WORK + 0 
00:a336 : 26 1b __ ROL ACCU + 0 
00:a338 : ca __ __ DEX
00:a339 : d0 eb __ BNE $a326 ; (divmod + 14)
00:a33b : 85 05 __ STA WORK + 2 
00:a33d : 60 __ __ RTS
00:a33e : a5 1b __ LDA ACCU + 0 
00:a340 : 85 05 __ STA WORK + 2 
00:a342 : a5 1c __ LDA ACCU + 1 
00:a344 : 85 06 __ STA WORK + 3 
00:a346 : a9 00 __ LDA #$00
00:a348 : 85 1b __ STA ACCU + 0 
00:a34a : 85 1c __ STA ACCU + 1 
00:a34c : 60 __ __ RTS
00:a34d : a5 04 __ LDA WORK + 1 
00:a34f : d0 1f __ BNE $a370 ; (divmod + 88)
00:a351 : a5 03 __ LDA WORK + 0 
00:a353 : 30 1b __ BMI $a370 ; (divmod + 88)
00:a355 : a9 00 __ LDA #$00
00:a357 : 85 06 __ STA WORK + 3 
00:a359 : a2 10 __ LDX #$10
00:a35b : 06 1b __ ASL ACCU + 0 
00:a35d : 26 1c __ ROL ACCU + 1 
00:a35f : 2a __ __ ROL
00:a360 : c5 03 __ CMP WORK + 0 
00:a362 : 90 02 __ BCC $a366 ; (divmod + 78)
00:a364 : e5 03 __ SBC WORK + 0 
00:a366 : 26 1b __ ROL ACCU + 0 
00:a368 : 26 1c __ ROL ACCU + 1 
00:a36a : ca __ __ DEX
00:a36b : d0 f2 __ BNE $a35f ; (divmod + 71)
00:a36d : 85 05 __ STA WORK + 2 
00:a36f : 60 __ __ RTS
00:a370 : a9 00 __ LDA #$00
00:a372 : 85 05 __ STA WORK + 2 
00:a374 : 85 06 __ STA WORK + 3 
00:a376 : 84 02 __ STY $02 
00:a378 : a0 10 __ LDY #$10
00:a37a : 18 __ __ CLC
00:a37b : 26 1b __ ROL ACCU + 0 
00:a37d : 26 1c __ ROL ACCU + 1 
00:a37f : 26 05 __ ROL WORK + 2 
00:a381 : 26 06 __ ROL WORK + 3 
00:a383 : 38 __ __ SEC
00:a384 : a5 05 __ LDA WORK + 2 
00:a386 : e5 03 __ SBC WORK + 0 
00:a388 : aa __ __ TAX
00:a389 : a5 06 __ LDA WORK + 3 
00:a38b : e5 04 __ SBC WORK + 1 
00:a38d : 90 04 __ BCC $a393 ; (divmod + 123)
00:a38f : 86 05 __ STX WORK + 2 
00:a391 : 85 06 __ STA WORK + 3 
00:a393 : 88 __ __ DEY
00:a394 : d0 e5 __ BNE $a37b ; (divmod + 99)
00:a396 : 26 1b __ ROL ACCU + 0 
00:a398 : 26 1c __ ROL ACCU + 1 
00:a39a : a4 02 __ LDY $02 
00:a39c : 60 __ __ RTS
--------------------------------------------------------------------
mods16: ; mods16
00:a39d : 24 1c __ BIT ACCU + 1 
00:a39f : 10 10 __ BPL $a3b1 ; (mods16 + 20)
00:a3a1 : 20 fc a2 JSR $a2fc ; (negaccu + 0)
00:a3a4 : 24 04 __ BIT WORK + 1 
00:a3a6 : 10 03 __ BPL $a3ab ; (mods16 + 14)
00:a3a8 : 20 0a a3 JSR $a30a ; (negtmp + 0)
00:a3ab : 20 18 a3 JSR $a318 ; (divmod + 0)
00:a3ae : 4c e6 a3 JMP $a3e6 ; (negtmpb + 0)
00:a3b1 : 24 04 __ BIT WORK + 1 
00:a3b3 : 10 03 __ BPL $a3b8 ; (mods16 + 27)
00:a3b5 : 20 0a a3 JSR $a30a ; (negtmp + 0)
00:a3b8 : 4c 18 a3 JMP $a318 ; (divmod + 0)
00:a3bb : 60 __ __ RTS
--------------------------------------------------------------------
negtmpb: ; negtmpb
00:a3e6 : 38 __ __ SEC
00:a3e7 : a9 00 __ LDA #$00
00:a3e9 : e5 05 __ SBC WORK + 2 
00:a3eb : 85 05 __ STA WORK + 2 
00:a3ed : a9 00 __ LDA #$00
00:a3ef : e5 06 __ SBC WORK + 3 
00:a3f1 : 85 06 __ STA WORK + 3 
00:a3f3 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16: ; f32_to_i16
00:a3f4 : 20 5d a0 JSR $a05d ; (freg + 36)
00:a3f7 : a5 07 __ LDA WORK + 4 
00:a3f9 : c9 7f __ CMP #$7f
00:a3fb : b0 07 __ BCS $a404 ; (f32_to_i16 + 16)
00:a3fd : a9 00 __ LDA #$00
00:a3ff : 85 1b __ STA ACCU + 0 
00:a401 : 85 1c __ STA ACCU + 1 
00:a403 : 60 __ __ RTS
00:a404 : e9 8e __ SBC #$8e
00:a406 : 90 16 __ BCC $a41e ; (f32_to_i16 + 42)
00:a408 : 24 1e __ BIT ACCU + 3 
00:a40a : 30 09 __ BMI $a415 ; (f32_to_i16 + 33)
00:a40c : a9 ff __ LDA #$ff
00:a40e : 85 1b __ STA ACCU + 0 
00:a410 : a9 7f __ LDA #$7f
00:a412 : 85 1c __ STA ACCU + 1 
00:a414 : 60 __ __ RTS
00:a415 : a9 00 __ LDA #$00
00:a417 : 85 1b __ STA ACCU + 0 
00:a419 : a9 80 __ LDA #$80
00:a41b : 85 1c __ STA ACCU + 1 
00:a41d : 60 __ __ RTS
00:a41e : aa __ __ TAX
00:a41f : a5 1c __ LDA ACCU + 1 
00:a421 : 46 1d __ LSR ACCU + 2 
00:a423 : 6a __ __ ROR
00:a424 : e8 __ __ INX
00:a425 : d0 fa __ BNE $a421 ; (f32_to_i16 + 45)
00:a427 : 24 1e __ BIT ACCU + 3 
00:a429 : 10 0e __ BPL $a439 ; (f32_to_i16 + 69)
00:a42b : 38 __ __ SEC
00:a42c : 49 ff __ EOR #$ff
00:a42e : 69 00 __ ADC #$00
00:a430 : 85 1b __ STA ACCU + 0 
00:a432 : a9 00 __ LDA #$00
00:a434 : e5 1d __ SBC ACCU + 2 
00:a436 : 85 1c __ STA ACCU + 1 
00:a438 : 60 __ __ RTS
00:a439 : 85 1b __ STA ACCU + 0 
00:a43b : a5 1d __ LDA ACCU + 2 
00:a43d : 85 1c __ STA ACCU + 1 
00:a43f : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float: ; sint16_to_float
00:a440 : 24 1c __ BIT ACCU + 1 
00:a442 : 30 03 __ BMI $a447 ; (sint16_to_float + 7)
00:a444 : 4c 5e a4 JMP $a45e ; (uint16_to_float + 0)
00:a447 : 38 __ __ SEC
00:a448 : a9 00 __ LDA #$00
00:a44a : e5 1b __ SBC ACCU + 0 
00:a44c : 85 1b __ STA ACCU + 0 
00:a44e : a9 00 __ LDA #$00
00:a450 : e5 1c __ SBC ACCU + 1 
00:a452 : 85 1c __ STA ACCU + 1 
00:a454 : 20 5e a4 JSR $a45e ; (uint16_to_float + 0)
00:a457 : a5 1e __ LDA ACCU + 3 
00:a459 : 09 80 __ ORA #$80
00:a45b : 85 1e __ STA ACCU + 3 
00:a45d : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float: ; uint16_to_float
00:a45e : a5 1b __ LDA ACCU + 0 
00:a460 : 05 1c __ ORA ACCU + 1 
00:a462 : d0 05 __ BNE $a469 ; (uint16_to_float + 11)
00:a464 : 85 1d __ STA ACCU + 2 
00:a466 : 85 1e __ STA ACCU + 3 
00:a468 : 60 __ __ RTS
00:a469 : a2 8e __ LDX #$8e
00:a46b : a5 1c __ LDA ACCU + 1 
00:a46d : 30 06 __ BMI $a475 ; (uint16_to_float + 23)
00:a46f : ca __ __ DEX
00:a470 : 06 1b __ ASL ACCU + 0 
00:a472 : 2a __ __ ROL
00:a473 : 10 fa __ BPL $a46f ; (uint16_to_float + 17)
00:a475 : 0a __ __ ASL
00:a476 : 85 1d __ STA ACCU + 2 
00:a478 : a5 1b __ LDA ACCU + 0 
00:a47a : 85 1c __ STA ACCU + 1 
00:a47c : 8a __ __ TXA
00:a47d : 4a __ __ LSR
00:a47e : 85 1e __ STA ACCU + 3 
00:a480 : a9 00 __ LDA #$00
00:a482 : 85 1b __ STA ACCU + 0 
00:a484 : 66 1d __ ROR ACCU + 2 
00:a486 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32: ; divmod32
00:a4a5 : 84 02 __ STY $02 
00:a4a7 : a0 20 __ LDY #$20
00:a4a9 : a9 00 __ LDA #$00
00:a4ab : 85 07 __ STA WORK + 4 
00:a4ad : 85 08 __ STA WORK + 5 
00:a4af : 85 09 __ STA WORK + 6 
00:a4b1 : 85 0a __ STA WORK + 7 
00:a4b3 : a5 05 __ LDA WORK + 2 
00:a4b5 : 05 06 __ ORA WORK + 3 
00:a4b7 : d0 78 __ BNE $a531 ; (divmod32 + 140)
00:a4b9 : a5 04 __ LDA WORK + 1 
00:a4bb : d0 27 __ BNE $a4e4 ; (divmod32 + 63)
00:a4bd : 18 __ __ CLC
00:a4be : 26 1b __ ROL ACCU + 0 
00:a4c0 : 26 1c __ ROL ACCU + 1 
00:a4c2 : 26 1d __ ROL ACCU + 2 
00:a4c4 : 26 1e __ ROL ACCU + 3 
00:a4c6 : 2a __ __ ROL
00:a4c7 : 90 05 __ BCC $a4ce ; (divmod32 + 41)
00:a4c9 : e5 03 __ SBC WORK + 0 
00:a4cb : 38 __ __ SEC
00:a4cc : b0 06 __ BCS $a4d4 ; (divmod32 + 47)
00:a4ce : c5 03 __ CMP WORK + 0 
00:a4d0 : 90 02 __ BCC $a4d4 ; (divmod32 + 47)
00:a4d2 : e5 03 __ SBC WORK + 0 
00:a4d4 : 88 __ __ DEY
00:a4d5 : d0 e7 __ BNE $a4be ; (divmod32 + 25)
00:a4d7 : 85 07 __ STA WORK + 4 
00:a4d9 : 26 1b __ ROL ACCU + 0 
00:a4db : 26 1c __ ROL ACCU + 1 
00:a4dd : 26 1d __ ROL ACCU + 2 
00:a4df : 26 1e __ ROL ACCU + 3 
00:a4e1 : a4 02 __ LDY $02 
00:a4e3 : 60 __ __ RTS
00:a4e4 : a5 1e __ LDA ACCU + 3 
00:a4e6 : d0 10 __ BNE $a4f8 ; (divmod32 + 83)
00:a4e8 : a6 1d __ LDX ACCU + 2 
00:a4ea : 86 1e __ STX ACCU + 3 
00:a4ec : a6 1c __ LDX ACCU + 1 
00:a4ee : 86 1d __ STX ACCU + 2 
00:a4f0 : a6 1b __ LDX ACCU + 0 
00:a4f2 : 86 1c __ STX ACCU + 1 
00:a4f4 : 85 1b __ STA ACCU + 0 
00:a4f6 : a0 18 __ LDY #$18
00:a4f8 : 18 __ __ CLC
00:a4f9 : 26 1b __ ROL ACCU + 0 
00:a4fb : 26 1c __ ROL ACCU + 1 
00:a4fd : 26 1d __ ROL ACCU + 2 
00:a4ff : 26 1e __ ROL ACCU + 3 
00:a501 : 26 07 __ ROL WORK + 4 
00:a503 : 26 08 __ ROL WORK + 5 
00:a505 : 90 0c __ BCC $a513 ; (divmod32 + 110)
00:a507 : a5 07 __ LDA WORK + 4 
00:a509 : e5 03 __ SBC WORK + 0 
00:a50b : aa __ __ TAX
00:a50c : a5 08 __ LDA WORK + 5 
00:a50e : e5 04 __ SBC WORK + 1 
00:a510 : 38 __ __ SEC
00:a511 : b0 0c __ BCS $a51f ; (divmod32 + 122)
00:a513 : 38 __ __ SEC
00:a514 : a5 07 __ LDA WORK + 4 
00:a516 : e5 03 __ SBC WORK + 0 
00:a518 : aa __ __ TAX
00:a519 : a5 08 __ LDA WORK + 5 
00:a51b : e5 04 __ SBC WORK + 1 
00:a51d : 90 04 __ BCC $a523 ; (divmod32 + 126)
00:a51f : 86 07 __ STX WORK + 4 
00:a521 : 85 08 __ STA WORK + 5 
00:a523 : 88 __ __ DEY
00:a524 : d0 d3 __ BNE $a4f9 ; (divmod32 + 84)
00:a526 : 26 1b __ ROL ACCU + 0 
00:a528 : 26 1c __ ROL ACCU + 1 
00:a52a : 26 1d __ ROL ACCU + 2 
00:a52c : 26 1e __ ROL ACCU + 3 
00:a52e : a4 02 __ LDY $02 
00:a530 : 60 __ __ RTS
00:a531 : a0 10 __ LDY #$10
00:a533 : a5 1e __ LDA ACCU + 3 
00:a535 : 85 08 __ STA WORK + 5 
00:a537 : a5 1d __ LDA ACCU + 2 
00:a539 : 85 07 __ STA WORK + 4 
00:a53b : a9 00 __ LDA #$00
00:a53d : 85 1d __ STA ACCU + 2 
00:a53f : 85 1e __ STA ACCU + 3 
00:a541 : 18 __ __ CLC
00:a542 : 26 1b __ ROL ACCU + 0 
00:a544 : 26 1c __ ROL ACCU + 1 
00:a546 : 26 07 __ ROL WORK + 4 
00:a548 : 26 08 __ ROL WORK + 5 
00:a54a : 26 09 __ ROL WORK + 6 
00:a54c : 26 0a __ ROL WORK + 7 
00:a54e : a5 07 __ LDA WORK + 4 
00:a550 : c5 03 __ CMP WORK + 0 
00:a552 : a5 08 __ LDA WORK + 5 
00:a554 : e5 04 __ SBC WORK + 1 
00:a556 : a5 09 __ LDA WORK + 6 
00:a558 : e5 05 __ SBC WORK + 2 
00:a55a : aa __ __ TAX
00:a55b : a5 0a __ LDA WORK + 7 
00:a55d : e5 06 __ SBC WORK + 3 
00:a55f : 90 11 __ BCC $a572 ; (divmod32 + 205)
00:a561 : 86 09 __ STX WORK + 6 
00:a563 : 85 0a __ STA WORK + 7 
00:a565 : a5 07 __ LDA WORK + 4 
00:a567 : e5 03 __ SBC WORK + 0 
00:a569 : 85 07 __ STA WORK + 4 
00:a56b : a5 08 __ LDA WORK + 5 
00:a56d : e5 04 __ SBC WORK + 1 
00:a56f : 85 08 __ STA WORK + 5 
00:a571 : 38 __ __ SEC
00:a572 : 88 __ __ DEY
00:a573 : d0 cd __ BNE $a542 ; (divmod32 + 157)
00:a575 : 26 1b __ ROL ACCU + 0 
00:a577 : 26 1c __ ROL ACCU + 1 
00:a579 : a4 02 __ LDY $02 
00:a57b : 60 __ __ RTS
--------------------------------------------------------------------
crt_malloc: ; crt_malloc
00:a57c : 18 __ __ CLC
00:a57d : a5 1b __ LDA ACCU + 0 
00:a57f : 69 05 __ ADC #$05
00:a581 : 29 fc __ AND #$fc
00:a583 : 85 03 __ STA WORK + 0 
00:a585 : a5 1c __ LDA ACCU + 1 
00:a587 : 69 00 __ ADC #$00
00:a589 : 85 04 __ STA WORK + 1 
00:a58b : ad 76 14 LDA $1476 ; (HeapNode.end + 0)
00:a58e : d0 26 __ BNE $a5b6 ; (crt_malloc + 58)
00:a590 : a9 00 __ LDA #$00
00:a592 : 8d 7a 14 STA $147a 
00:a595 : 8d 7b 14 STA $147b 
00:a598 : ee 76 14 INC $1476 ; (HeapNode.end + 0)
00:a59b : a9 78 __ LDA #$78
00:a59d : 09 02 __ ORA #$02
00:a59f : 8d 74 14 STA $1474 ; (HeapNode.next + 0)
00:a5a2 : a9 14 __ LDA #$14
00:a5a4 : 8d 75 14 STA $1475 ; (HeapNode.next + 1)
00:a5a7 : 38 __ __ SEC
00:a5a8 : a9 00 __ LDA #$00
00:a5aa : e9 02 __ SBC #$02
00:a5ac : 8d 7c 14 STA $147c 
00:a5af : a9 37 __ LDA #$37
00:a5b1 : e9 00 __ SBC #$00
00:a5b3 : 8d 7d 14 STA $147d 
00:a5b6 : a9 74 __ LDA #$74
00:a5b8 : a2 14 __ LDX #$14
00:a5ba : 85 1d __ STA ACCU + 2 
00:a5bc : 86 1e __ STX ACCU + 3 
00:a5be : 18 __ __ CLC
00:a5bf : a0 00 __ LDY #$00
00:a5c1 : b1 1d __ LDA (ACCU + 2),y 
00:a5c3 : 85 1b __ STA ACCU + 0 
00:a5c5 : 65 03 __ ADC WORK + 0 
00:a5c7 : 85 05 __ STA WORK + 2 
00:a5c9 : c8 __ __ INY
00:a5ca : b1 1d __ LDA (ACCU + 2),y 
00:a5cc : 85 1c __ STA ACCU + 1 
00:a5ce : f0 20 __ BEQ $a5f0 ; (crt_malloc + 116)
00:a5d0 : 65 04 __ ADC WORK + 1 
00:a5d2 : 85 06 __ STA WORK + 3 
00:a5d4 : b0 14 __ BCS $a5ea ; (crt_malloc + 110)
00:a5d6 : a0 02 __ LDY #$02
00:a5d8 : b1 1b __ LDA (ACCU + 0),y 
00:a5da : c5 05 __ CMP WORK + 2 
00:a5dc : c8 __ __ INY
00:a5dd : b1 1b __ LDA (ACCU + 0),y 
00:a5df : e5 06 __ SBC WORK + 3 
00:a5e1 : b0 0e __ BCS $a5f1 ; (crt_malloc + 117)
00:a5e3 : a5 1b __ LDA ACCU + 0 
00:a5e5 : a6 1c __ LDX ACCU + 1 
00:a5e7 : 4c ba a5 JMP $a5ba ; (crt_malloc + 62)
00:a5ea : a9 00 __ LDA #$00
00:a5ec : 85 1b __ STA ACCU + 0 
00:a5ee : 85 1c __ STA ACCU + 1 
00:a5f0 : 60 __ __ RTS
00:a5f1 : a5 05 __ LDA WORK + 2 
00:a5f3 : 85 07 __ STA WORK + 4 
00:a5f5 : a5 06 __ LDA WORK + 3 
00:a5f7 : 85 08 __ STA WORK + 5 
00:a5f9 : a0 02 __ LDY #$02
00:a5fb : a5 07 __ LDA WORK + 4 
00:a5fd : d1 1b __ CMP (ACCU + 0),y 
00:a5ff : d0 15 __ BNE $a616 ; (crt_malloc + 154)
00:a601 : c8 __ __ INY
00:a602 : a5 08 __ LDA WORK + 5 
00:a604 : d1 1b __ CMP (ACCU + 0),y 
00:a606 : d0 0e __ BNE $a616 ; (crt_malloc + 154)
00:a608 : a0 00 __ LDY #$00
00:a60a : b1 1b __ LDA (ACCU + 0),y 
00:a60c : 91 1d __ STA (ACCU + 2),y 
00:a60e : c8 __ __ INY
00:a60f : b1 1b __ LDA (ACCU + 0),y 
00:a611 : 91 1d __ STA (ACCU + 2),y 
00:a613 : 4c 33 a6 JMP $a633 ; (crt_malloc + 183)
00:a616 : a0 00 __ LDY #$00
00:a618 : b1 1b __ LDA (ACCU + 0),y 
00:a61a : 91 07 __ STA (WORK + 4),y 
00:a61c : a5 07 __ LDA WORK + 4 
00:a61e : 91 1d __ STA (ACCU + 2),y 
00:a620 : c8 __ __ INY
00:a621 : b1 1b __ LDA (ACCU + 0),y 
00:a623 : 91 07 __ STA (WORK + 4),y 
00:a625 : a5 08 __ LDA WORK + 5 
00:a627 : 91 1d __ STA (ACCU + 2),y 
00:a629 : c8 __ __ INY
00:a62a : b1 1b __ LDA (ACCU + 0),y 
00:a62c : 91 07 __ STA (WORK + 4),y 
00:a62e : c8 __ __ INY
00:a62f : b1 1b __ LDA (ACCU + 0),y 
00:a631 : 91 07 __ STA (WORK + 4),y 
00:a633 : a0 00 __ LDY #$00
00:a635 : a5 05 __ LDA WORK + 2 
00:a637 : 91 1b __ STA (ACCU + 0),y 
00:a639 : c8 __ __ INY
00:a63a : a5 06 __ LDA WORK + 3 
00:a63c : 91 1b __ STA (ACCU + 0),y 
00:a63e : 18 __ __ CLC
00:a63f : a5 1b __ LDA ACCU + 0 
00:a641 : 69 02 __ ADC #$02
00:a643 : 85 1b __ STA ACCU + 0 
00:a645 : 90 02 __ BCC $a649 ; (crt_malloc + 205)
00:a647 : e6 1c __ INC ACCU + 1 
00:a649 : 60 __ __ RTS
--------------------------------------------------------------------
crt_free@proxy: ; crt_free@proxy
00:a64a : a5 0d __ LDA P0 
00:a64c : 85 1b __ STA ACCU + 0 
00:a64e : a5 0e __ LDA P1 
00:a650 : 85 1c __ STA ACCU + 1 
--------------------------------------------------------------------
crt_free: ; crt_free
00:a652 : a5 1b __ LDA ACCU + 0 
00:a654 : 05 1c __ ORA ACCU + 1 
00:a656 : d0 01 __ BNE $a659 ; (crt_free + 7)
00:a658 : 60 __ __ RTS
00:a659 : 38 __ __ SEC
00:a65a : a5 1b __ LDA ACCU + 0 
00:a65c : e9 02 __ SBC #$02
00:a65e : 85 1b __ STA ACCU + 0 
00:a660 : b0 02 __ BCS $a664 ; (crt_free + 18)
00:a662 : c6 1c __ DEC ACCU + 1 
00:a664 : a0 00 __ LDY #$00
00:a666 : b1 1b __ LDA (ACCU + 0),y 
00:a668 : 85 1d __ STA ACCU + 2 
00:a66a : c8 __ __ INY
00:a66b : b1 1b __ LDA (ACCU + 0),y 
00:a66d : 85 1e __ STA ACCU + 3 
00:a66f : a9 74 __ LDA #$74
00:a671 : a2 14 __ LDX #$14
00:a673 : 85 05 __ STA WORK + 2 
00:a675 : 86 06 __ STX WORK + 3 
00:a677 : a0 01 __ LDY #$01
00:a679 : b1 05 __ LDA (WORK + 2),y 
00:a67b : f0 28 __ BEQ $a6a5 ; (crt_free + 83)
00:a67d : aa __ __ TAX
00:a67e : 88 __ __ DEY
00:a67f : b1 05 __ LDA (WORK + 2),y 
00:a681 : e4 1e __ CPX ACCU + 3 
00:a683 : 90 ee __ BCC $a673 ; (crt_free + 33)
00:a685 : d0 1e __ BNE $a6a5 ; (crt_free + 83)
00:a687 : c5 1d __ CMP ACCU + 2 
00:a689 : 90 e8 __ BCC $a673 ; (crt_free + 33)
00:a68b : d0 18 __ BNE $a6a5 ; (crt_free + 83)
00:a68d : a0 00 __ LDY #$00
00:a68f : b1 1d __ LDA (ACCU + 2),y 
00:a691 : 91 1b __ STA (ACCU + 0),y 
00:a693 : c8 __ __ INY
00:a694 : b1 1d __ LDA (ACCU + 2),y 
00:a696 : 91 1b __ STA (ACCU + 0),y 
00:a698 : c8 __ __ INY
00:a699 : b1 1d __ LDA (ACCU + 2),y 
00:a69b : 91 1b __ STA (ACCU + 0),y 
00:a69d : c8 __ __ INY
00:a69e : b1 1d __ LDA (ACCU + 2),y 
00:a6a0 : 91 1b __ STA (ACCU + 0),y 
00:a6a2 : 4c ba a6 JMP $a6ba ; (crt_free + 104)
00:a6a5 : a0 00 __ LDY #$00
00:a6a7 : b1 05 __ LDA (WORK + 2),y 
00:a6a9 : 91 1b __ STA (ACCU + 0),y 
00:a6ab : c8 __ __ INY
00:a6ac : b1 05 __ LDA (WORK + 2),y 
00:a6ae : 91 1b __ STA (ACCU + 0),y 
00:a6b0 : c8 __ __ INY
00:a6b1 : a5 1d __ LDA ACCU + 2 
00:a6b3 : 91 1b __ STA (ACCU + 0),y 
00:a6b5 : c8 __ __ INY
00:a6b6 : a5 1e __ LDA ACCU + 3 
00:a6b8 : 91 1b __ STA (ACCU + 0),y 
00:a6ba : a0 02 __ LDY #$02
00:a6bc : b1 05 __ LDA (WORK + 2),y 
00:a6be : c5 1b __ CMP ACCU + 0 
00:a6c0 : d0 1d __ BNE $a6df ; (crt_free + 141)
00:a6c2 : c8 __ __ INY
00:a6c3 : b1 05 __ LDA (WORK + 2),y 
00:a6c5 : c5 1c __ CMP ACCU + 1 
00:a6c7 : d0 16 __ BNE $a6df ; (crt_free + 141)
00:a6c9 : a0 00 __ LDY #$00
00:a6cb : b1 1b __ LDA (ACCU + 0),y 
00:a6cd : 91 05 __ STA (WORK + 2),y 
00:a6cf : c8 __ __ INY
00:a6d0 : b1 1b __ LDA (ACCU + 0),y 
00:a6d2 : 91 05 __ STA (WORK + 2),y 
00:a6d4 : c8 __ __ INY
00:a6d5 : b1 1b __ LDA (ACCU + 0),y 
00:a6d7 : 91 05 __ STA (WORK + 2),y 
00:a6d9 : c8 __ __ INY
00:a6da : b1 1b __ LDA (ACCU + 0),y 
00:a6dc : 91 05 __ STA (WORK + 2),y 
00:a6de : 60 __ __ RTS
00:a6df : a0 00 __ LDY #$00
00:a6e1 : a5 1b __ LDA ACCU + 0 
00:a6e3 : 91 05 __ STA (WORK + 2),y 
00:a6e5 : c8 __ __ INY
00:a6e6 : a5 1c __ LDA ACCU + 1 
00:a6e8 : 91 05 __ STA (WORK + 2),y 
00:a6ea : 60 __ __ RTS
--------------------------------------------------------------------
print_at_color@proxy: ; print_at_color@proxy
00:a6eb : a9 00 __ LDA #$00
00:a6ed : 85 0d __ STA P0 
00:a6ef : a9 fe __ LDA #$fe
00:a6f1 : 85 0f __ STA P2 
00:a6f3 : a9 89 __ LDA #$89
00:a6f5 : 85 10 __ STA P3 
00:a6f7 : a9 01 __ LDA #$01
00:a6f9 : 85 11 __ STA P4 
00:a6fb : 4c a9 8e JMP $8ea9 ; (print_at_color.s4 + 0)
--------------------------------------------------------------------
freg@proxy: ; freg@proxy
00:a6fe : a9 20 __ LDA #$20
00:a700 : 85 05 __ STA WORK + 2 
00:a702 : a9 41 __ LDA #$41
00:a704 : 85 06 __ STA WORK + 3 
00:a706 : 4c 4d a0 JMP $a04d ; (freg + 20)
--------------------------------------------------------------------
freg@proxy: ; freg@proxy
00:a709 : a5 43 __ LDA $43 
00:a70b : 85 1b __ STA ACCU + 0 
00:a70d : a5 44 __ LDA $44 
00:a70f : 85 1c __ STA ACCU + 1 
00:a711 : a5 45 __ LDA $45 
00:a713 : 85 1d __ STA ACCU + 2 
00:a715 : a5 46 __ LDA $46 
00:a717 : 85 1e __ STA ACCU + 3 
00:a719 : 4c 3d a0 JMP $a03d ; (freg + 4)
--------------------------------------------------------------------
strchr@proxy: ; strchr@proxy
00:a71c : a9 0d __ LDA #$0d
00:a71e : 85 0d __ STA P0 
00:a720 : a9 11 __ LDA #$11
00:a722 : 85 0e __ STA P1 
00:a724 : a9 20 __ LDA #$20
00:a726 : 85 0f __ STA P2 
00:a728 : a9 00 __ LDA #$00
00:a72a : 85 10 __ STA P3 
00:a72c : 4c 90 8c JMP $8c90 ; (strchr.l4 + 0)
--------------------------------------------------------------------
atoi@proxy: ; atoi@proxy
00:a72f : a9 0a __ LDA #$0a
00:a731 : 85 0d __ STA P0 
00:a733 : a9 11 __ LDA #$11
00:a735 : 85 0e __ STA P1 
00:a737 : 4c d6 8b JMP $8bd6 ; (atoi.l4 + 0)
--------------------------------------------------------------------
uci_socket_write@proxy: ; uci_socket_write@proxy
00:a73a : ad 58 a7 LDA $a758 ; (socket_id + 0)
00:a73d : 85 11 __ STA P4 
00:a73f : 4c 39 8b JMP $8b39 ; (uci_socket_write.s4 + 0)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
00:a742 : a9 00 __ LDA #$00
00:a744 : 85 0d __ STA P0 
00:a746 : a9 04 __ LDA #$04
00:a748 : 85 0e __ STA P1 
00:a74a : 4c dc 84 JMP $84dc ; (print_at.s4 + 0)
--------------------------------------------------------------------
print_at@proxy: ; print_at@proxy
00:a74d : a9 00 __ LDA #$00
00:a74f : 85 0d __ STA P0 
00:a751 : 4c dc 84 JMP $84dc ; (print_at.s4 + 0)
--------------------------------------------------------------------
uci_data_index:
00:a754 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
uci_data_len:
00:a756 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
socket_id:
00:a758 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
connected:
00:a759 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
item_count:
00:a75a : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
total_count:
00:a75c : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
cursor:
00:a75e : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
offset:
00:a760 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
current_page:
00:a762 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
search_query_len:
00:a764 : __ __ __ BYT 00 00                                           : ..
--------------------------------------------------------------------
fround5:
00:a766 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
00:a776 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
keyb_codes:
00:a800 : __ __ __ BYT 14 0d 1d 88 85 86 87 11 33 77 61 34 7a 73 65 00 : ........3wa4zse.
00:a810 : __ __ __ BYT 35 72 64 36 63 66 74 78 37 79 67 38 62 68 75 76 : 5rd6cftx7yg8bhuv
00:a820 : __ __ __ BYT 39 69 6a 30 6d 6b 6f 6e 2b 70 6c 2d 2e 3a 40 2c : 9ij0mkon+pl-.:@,
00:a830 : __ __ __ BYT 00 2a 3b 13 00 3d 5e 2f 31 5f 00 32 20 00 71 1b : .*;..=^/1_.2 .q.
00:a840 : __ __ __ BYT 94 0d 9d 8c 89 8a 8b 91 23 57 41 24 5a 53 45 00 : ........#WA$ZSE.
00:a850 : __ __ __ BYT 25 52 44 26 43 46 54 58 27 59 47 28 42 48 55 56 : %RD&CFTX'YG(BHUV
00:a860 : __ __ __ BYT 29 49 4a 30 4d 4b 4f 4e 00 50 4c 00 3e 5b 40 3c : )IJ0MKON.PL.>[@<
00:a870 : __ __ __ BYT 00 00 5d 93 00 00 5e 3f 21 00 00 22 20 00 51 1b : ..]...^?!.." .Q.
