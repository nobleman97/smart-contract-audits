# Audit Store

A store for all my smart contract audits

_Primary Tool:_ **Slither**

```
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠖⣲⢾⣭⠽⠏⠉⠑⠒⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⡟⠁⠀⣼⡧⠊⠁⣠⠔⠒⠒⠒⠢⡝⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢾⡕⢹⠇⠀⠐⠋⠀⢠⣾⠵⠒⠋⠉⠉⠉⠻⣌⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢞⣱⠈⢧⣸⡄⠀⠀⠀⠀⠉⠀⠀⣀⣤⠤⣄⡀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⠟⣿⡀⠀⠉⠓⠀⣀⣤⣬⡆⢰⣯⣥⣤⣤⣤⣙⣦⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠫⢧⣄⠘⣿⡄⠀⢴⡺⠗⠊⣹⠟⠀⠀⠀⠀⠀⠀⠀⠉⠁⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣻⣇⠀⠈⠉⠉⠉⡴⠋⠑⢦⡴⣣⠶⠒⠉⠉⠑⠲⢤⡀⠀⠀⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠏⡇⠈⢧⡀⠀⢀⡾⣄⣀⡴⠋⠚⠉⠉⠓⠶⠒⠒⠉⠙⠃⠀⣼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠓⠒⠒⠛⠁⡞⢀⡤⠾⣦⣤⠤⠤⢤⡤⠤⠤⣄⣴⠶⣤⡼⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⠳⣄⡀⠀⢸⠁⢸⣱⡀⡠⠙⡧⠤⠄⠀⠤⣴⠳⣄⢀⣎⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⢻⣀⠤⠝⠁⢸⣴⠛⢻⡏⢷⡤⠙⢦⠀⠀⣤⠊⢤⡾⢻⣟⢛⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢠⣤⡀⠀⠀⢸⣿⣠⠚⣻⣻⣷⡶⠾⣀⢀⠿⣶⣼⣟⣿⡛⣄⡟⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣮⣇⣉⠟⠂⢸⣽⡷⡄⠀⣈⡻⠿⠚⠍⠩⠇⠽⢿⣁⠀⢡⢼⣥⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣌⠁⠀⠀⠀⠉⢻⣷⠤⣀⣀⣀⣀⣰⣦⣂⣀⣀⣀⡤⣾⡟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⢲⠒⠚⢛⡟⠀⢹⣷⢶⠓⣿⣷⣾⣷⣿⣿⡒⣿⣾⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⣳⡤⠋⠀⠀⠀⢻⡼⣆⣿⣿⣯⣭⣿⣿⣷⢧⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡤⡶⠖⠒⣲⠎⣿⣸⣿⣿⡧⣿⣿⣿⡃⣿⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣞⠢⡔⠁⠀⣸⣯⠙⠙⢳⡘⣏⡟⣽⠇⠀⠈⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣝⠫⣭⡿⣍⠉⠉⢙⣇⡟⣩⡥⠄⠀⢀⣤⠌⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣌⠀⠙⠯⣲⣎⣸⣻⡏⢀⡠⠞⠉⠀⠀⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢤⡀⠈⡆⢀⠇⠹⡍⠀⠀⠀⠀⢀⡰⠆⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⣋⠹⡶⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢦⡉⠉⠀⠀⠘⢦⣀⣠⠞⠁⠀⠀⠀⠀⠀⠘⢧⡀⠀⠀⠀⠀⠀⠀
⠀⣿⣄⡝⠆⣨⠟⢳⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣜⣿⣛⡟⠻⣄⠀⠀⠀⠀⠀⣠⠄⠀⠀⠙⣄⠀⠀⠀⠀⠀
⠀⠈⠹⣷⣼⠉⠣⣔⠉⢻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢭⡁⠀⠈⢳⡀⣠⠴⠋⠀⠀⠀⠀⠀⠈⢧⡀⠀⠀⠀
⠀⠀⠀⠈⠻⣤⡏⠀⡱⣄⢠⠟⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢟⠿⠟⠙⢦⠀⠀⠀⠀⠀⢀⣠⠄⠀⢻⡄⠀⠀
⠀⠀⠀⠀⠀⠘⢿⣾⡁⣨⠓⢄⡘⠋⣙⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⡴⣖⡶⠳⣄⣀⡤⠞⠋⠀⠀⠀⠀⢻⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠙⠿⣧⣀⡆⣽⠋⠉⠉⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢯⣀⣀⣙⣧⡀⠀⠀⠀⠀⠀⠀⠀⢳⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢷⣯⡀⢀⣤⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡳⠟⠉⢳⡀⢀⣀⠠⠀⠀⠀⠈⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠙⢣⠀⠈⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣤⣄⣀⡻⡍⠁⠀⠀⠀⠀⠀⢷              Slithering through the Dark Forest
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣷⠶⠭⠇⠀⢸⣤⣤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣯⠷⠛⠁⢹⡄⠀⠀⠀⠀⠀⢸
⠀⠀⠀⠀⠀⠀⠀⢀⣠⡴⢶⣞⣋⢩⡇⠀⡠⢴⠀⠘⡆⠹⡒⢦⡍⠉⢩⣭⣿⣒⠒⠦⣤⣤⣄⡀⠀⠀⢸⠀⠀⠀⠀⢻⡤⠒⠂⠀⠀⢸
⠀⠀⠀⠀⣠⡶⢛⣽⣤⣤⠈⠱⣽⢸⠀⠚⠒⠺⠀⠀⢧⠀⠑⠋⠀⠀⠀⢹⣄⠔⠋⠀⠐⡖⠚⢯⡝⢲⡟⡾⡆⠀⠀⠀⢷⠀⠀⠀⠀⢸
⠀⢀⣴⠟⠁⠞⠛⠉⠓⢾⠀⠀⠀⠸⡄⠀⢀⣴⡛⢆⠘⢷⡀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⠷⠒⠋⢀⡾⠿⣄⣈⢢⣄⠀⢸⠀⠤⠖⠀⢸
⢠⡟⠁⠀⠀⠀⣀⣀⣀⣦⠀⠀⠀⠀⣷⡀⠈⠁⠈⢹⣄⠀⠙⢶⡶⠶⠤⢤⣀⣀⠀⠀⠀⠀⣠⠖⣋⣤⠀⠀⠈⠉⠁⠀⠘⡇⠀⠀⠀⡏
⣿⠀⠀⠀⠀⡼⢃⡠⠾⠛⢲⣮⣍⣁⣬⣷⣄⡀⠤⠾⠭⠷⠄⠀⠙⠳⢦⣄⣀⡠⠽⢿⠚⠉⢰⡏⠁⠻⡀⠀⠀⠀⠀⠀⢠⠇⠀⠀⢸⠃
⢿⠀⠀⠀⠀⡟⠋⠀⠀⡴⠋⢉⡿⠀⠀⢠⠾⠿⣿⡍⠉⠉⡯⠭⠽⣽⠉⠀⡴⠖⠚⠙⡇⠀⠀⠳⣄⠀⠻⣄⠀⠀⠀⠀⡼⠒⠒⣰⠏⠀
⠘⢧⠀⠀⠀⠀⠀⠀⠀⡇⢀⠞⠀⠀⠀⡞⠀⣰⠏⠀⠀⢸⡅⠀⣰⠏⠀⠀⢹⡀⠀⠀⡇⠀⠀⠀⠀⠙⠓⠾⠆⠀⠀⣼⠃⢀⣼⠃⠀⠀
⠀⠈⠳⡀⠀⠀⠀⠀⠀⢷⡟⠀⠀⠀⠀⣇⣰⠏⠀⠀⠀⠀⡇⠀⡇⠀⠀⠀⠀⠳⡀⢸⠁⠀⠀⠀⠀⠀⠀⠀⠀⢠⠞⠓⣤⠟⠁⠀⠀⠀
⠀⠀⠀⠈⠲⣄⡀⠀⠀⠈⠀⠀⠀⠀⠀⠘⠛⠀⠀⠀⠀⠀⠹⣾⠀⠀⠀⠀⠀⠀⠙⢾⠀⠀⠀⠀⠀⠀⠀⣀⠔⣫⡴⠞⠃⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠉⠓⠦⢄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⡾⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠒⠒⠶⠤⠤⠤⠤⣤⣤⣤⣤⣤⣤⣤⠤⠤⠤⠤⠴⠶⠒⠒⠛⢉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
```