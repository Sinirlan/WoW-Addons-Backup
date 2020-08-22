# WoW-Addons-Backup


Introduction
------------
Very sporadically it happens that Wow.exe crashes and in process all configs of 
addons are wiped and You have to go trough setting them up, sometimes it might 
take very long time to get addons back to way they were beforhand. It doesn't happen often
but better to be safe than sorry!


Usage
-----
### Script is having two parameters:
`-wow_folder <Path>` - (required) specifies folder path in which WoW is installed  
`-history <number>` - (optional) if specified will delete backups older than provided number of days

---------
#### To run script from powershell (assuming Your WoW is installed in default location):  

    ./addons_backup.ps1 -wow_folder 'C:\Program Files (x86)\World of Warcraft' -history 14

It will create zip archive in place where script is located, there will be separate archive for retail and classic, it will also attempt deleting archives older than 14 days

#### To run script with Task Scheduler

Best way by far is is to set up taks in **Task Scheduler**, built in Windows tool which will run script automatically on login or specified times.

Download script file `addons_backup.ps1` and place it in folder You will want to have Your backup files stored, in this example  
I will use `D:\Documents\WoW-Addons-Backup`

1. Search for "Task Scheduler" in Start Menu
![Image1](https://github.com/Sinirlan/WoW-Addons-Backup/blob/master/images/1.png)
2. On right hand side click on **Create Task**
![Image2](https://github.com/Sinirlan/WoW-Addons-Backup/blob/master/images/2.png)
3. Enter task name in field **Name** and then click on tab **Triggers**
![Image3](https://github.com/Sinirlan/WoW-Addons-Backup/blob/master/images/3.png)
4. On Triggers tab click **New**, check options available in drop down on top of the window and choose the one which suits You, 
for purpose of this manual we will use "On a schedule", it will run once a week on Sunday at 14:00 (02:00 PM). After setting up trigger click OK and then switch to **Actions** tab
![Image5](https://github.com/Sinirlan/WoW-Addons-Backup/blob/master/images/5.png)
5. Again click **New**, from Action drop down select "Start a program" other fields fill with following values:


| Field   |      Value      |
|----------|-------------|
| Program/script |  `Powershell` |
| Add arguments | `-windowstyle hidden -ExecutionPolicy Bypass -File "D:\Documents\WoW-Addons-Backup\addons_backup.ps1" -wow_folder "C:\Program Files (x86)\World of Warcraft" -history 14`  |
| Start in | `D:\Documents\WoW-Addons-Backup` |

About arguments:  
`-windowstyle hidden` - prevents powershell window from poping up, runs in "silent mode"  
`-ExecutionPolicy Bypass` - by default scripts execution is blocked, this argument allows to run the script without changing policy for whole system
![Image7](https://github.com/Sinirlan/WoW-Addons-Backup/blob/master/images/7.png)
6. Last option to set is in tab **Settings**, make sure to check option **Run task as soon as possible after a scheduled start is missed** that way task will run if for example computer was off for longer time
