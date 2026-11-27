Ben 10 Omniverse: Galactic Champions Mod Code Transylian (Frankenstrike)
-
PC version (Windows):
-
build.ps1 builds our own Ruffle (Ruffle 0.8.0 + ruffle\ruffle.patch) as Ben10GalacticChampions.exe and puts the game next to the repo, in ..\Ben10GalacticChampions (the .exe, game\, saves\ and licencias\). Nothing is built inside the repo.
- Requirements: git, Rust (rustup), Visual Studio Build Tools 2022 (C++ workload), Java
- .\build.ps1: downloads Ruffle to ..\ruffle-src, applies the patch and the icon, compiles (first time ~5 min) and builds the game folder from the last commit of game\
- .\build.ps1 -SinCompilar: only rebuilds the game folder; -Destino C:\Juegos: puts it somewhere else
- Double-click Ben10GalacticChampions.exe: it opens the game directly, with its own title and icon, and keeps the save in saves\, so the folder can be moved or copied
- Full screen: create opciones.ini next to the .exe with the line pantalla_completa=1
- Old save: copy galacticchampions.sol to saves\galacticchampions.local\game.swf\ (with the game closed)

Option 1:
-
Branches in GitHub:
- Portuguese: github.com/leoibing/Galactic-Champions-Mod-Code/tree/main
- English: github.com/leoibing/Galactic-Champions-Mod-Code/tree/eng
- Spanish: github.com/leoibing/Galactic-Champions-Mod-Code/tree/esp

Download:
- Click "<> Code" button, click on "Download ZIP"

Unpack ".zip"
- Using 7-Zip (Download in 7-zip.org) or WinRAR (Download in win-rar.com)

Download Ruffle: ruffle.rs
- Open Ruffle, click File, Open File, look for your folder, select game\game.swf, click Open, then play
- Uses the codes from texts-.xml, 0 unlocks Transylian

You can delete the git files, .gitattributes and README.md

Option 2:
-
Same as option 1, but using Adobe Flash Player (or Ruffle) from Flashpoint

Option 3:
-
Download Flashpoint Infinity: flashpointarchive.org (Flashpoint has Adobe Flash Player and Ruffle installed)

Install game Galactic Champions in Flashpoint, launch a new game, and close the game
- The files will be located in: \Flashpoint\Data\Games\13e608b7-75c4-4f82-97f2-4e09efc768bc-1766019759680.zip and unpack ".zip" or
- \Flashpoint\Legacy\htdocs\emea.iframed.cn.dmti.cloud\content\320\game\galactic-champions\uk\galactic-champions-100615

Using the notepad:

Where it says "por" and "esp" put "eng" (or whatever language you want):
- config.xml: term key="language">eng</term
- config.json: "lang": "eng",
- texts-eng.xml: term key="frame_label_default">eng</term

In config.xml:
- Activate the code: term key="use_codes">true</term

texts-eng.xml:
- Put "0,trick" (Both "0" and "trick" function as code): term key="codes-alien-Transylian">0,trick</term

Can change the errors in texts-eng.xml and texts-esp.xml:

eng:
- ARACNOCHIMPANCÉ: ARACHNACHIMP
- NECROFRIGGIANO: NECROFRIGGIAN
- VAXASAURIANO: VAXASAURIAN
- ARACNA: ARANHASCIMMIA

eng and esp:
- SMOOTHIES: SMOOTHIE, SMOOTH (Very long sentence in REWARDs)
- CORRODIUM: ELEMENT X/SUB-ENERGY, ELEMENTO X/SUB-ENERGÍA (that makes more sense, Corrodium mutates organisms)
- MAGIC, MANÁ: LIFE, SALUD
- TRANSYL: ANUR TRANSYL
- MYKDL'DY: MIKD'LTY
- RANCHULA: TERRORANCHULA, TERRORÁNTULA
- AMBER OGÍA: AMBER OGIA, OGIA ÁMBAR
- HELIXIR HOKESTAR: MIRACLE ELIXIR, ELIXIR MILAGROSO
- GOLD, ORO: TAYDEN

esp:
- PYRONITE: PYRONITA
- SHOCK: ONDA DE CHOQUE
- BLOCK: BLOQUEAR
- ESPECIALES: ESPECIAL (Very long sentence in REWARDs)
- TYRANNOPEDE: TIRANÓPIDO

Open Adobe Flash Player or Ruffle and select game.swf, then play

In GitHub:
-
Translated and adapted into Portuguese:
- For Portuguese, it doesn't work in THURSTON_erc: Ã, Ô e Õ; only 0/a/b (which in some swfs looks like Ã in the game); Ă (which looks like Ä in the game); 1 (which in some swfs looks like Ô in the game) e  NEL {} (which looks like Ö in the game)
- I modified all THURSTON_erc (with JPEXS Free Flash Decompiler) in the swf so that all 0/a/b values are Ã, and all 1 values are Ô

In all texts-.xml:
- LVL remains as LVL because there is an error where it appears as VL in the SELECT YOUR TEAM section of QUICK FIGHT and TOURNAMENT, and as LVL in the REQUIREMENTs section of TOURNAMENT
- Anything not used in the game is in lowercase, with A, B and accented letters in uppercase
- The official name of the species "INSECTOID" is unknown in the three languages
- Identical words replaced by similar words

<img width="3841" height="2071" alt="Galactic-Champions-Mod-Code (0)" src="https://github.com/user-attachments/assets/d401d5cb-8f51-4aef-90bc-ba4af2059c2d" />
<img width="3839" height="2065" alt="Galactic-Champions-Mod-Code (1)" src="https://github.com/user-attachments/assets/6d07714e-523d-4234-ada0-7f58ff22cdd1" />
<img width="1765" height="974" alt="Galactic-Champions-Mod-Code (4)" src="https://github.com/user-attachments/assets/891352a4-d4c4-4380-9a93-8732e83bc079" />
<img width="1761" height="1035" alt="Galactic-Champions-Mod-Code (5)" src="https://github.com/user-attachments/assets/627b706c-fd36-4db2-b5e4-a38ca3917647" />
<img width="1702" height="909" alt="Galactic-Champions-Mod-Code (2)" src="https://github.com/user-attachments/assets/9f0f9c49-164c-46c0-b6c1-c437f5becbec" />
<img width="1508" height="912" alt="Galactic-Champions-Mod-Code (3)" src="https://github.com/user-attachments/assets/636b1e46-81a0-499b-b85d-b931969baccc" />
