# DeepRacer Local Installation

## Introduction
The scripts in this repository can be used to set up your environment for training an AWS DeepRacer model locally, for Windows and for Linux.

This configuration is primarily made for computers running Linux, or Windows with WSL2 support. The scripts will automatically detect WSL compatability, but if you want more information, [view the installation guide here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

If you are familiar with command prompt and shell, or you already have some components installed (Docker, WSL, Ubuntu, etc.), skim the guide to make sure you aren't missing anything.

---

## Installation
Clone this repository to your machine. If you do not have Git installed, [download the files here](https://github.com/NathanDuPont/deepracer-local-install/archive/main.zip).

Once you have downloaded the files, **copy** the path to the files. This can be done by clicking in the box above your files, and copying the text present. It should look something like this:

![File Explorer Path](/img/file-explorer-path.png)

Next, open an **administrator command prompt or Powershell window**. On Windows, this can be done by doing the following:

1. Press [Windows] + [R] to open the "Run" window
2. Type "cmd" into the box
3. Press [Ctrl] + [Shift] + [Enter]
4. A command window should open up. This should have the title "Administrator: C:\\..."
5. Check the path you copied earlier. If it starts with a letter **other than** C (such as how mine starts with D), type the letter followed by a colon into the prompt, and press enter.
    - For the path above, I would type "D:" and press enter
6. Type "cd " into the prompt (followed by a space), and right click to paste the path copied earlier. Press enter once the path is in the command prompt
7. Now, your command prompt should look something like this:

![Example Prompt Output](/img/example-prompt-output.png)

Now, type the following commands in to run the scripts. If it prompts you to give permission, enter "Yes", "Y", or press Ok.

`powershell Set-ExecutionPolicy Unrestricted`<br>
`powershell .\windows-install.ps1`

This will take you through installation. **Installation will require you to restart your computer if you don't currently have WSL installed**. Please follow the prompts in the install scripts.

---

## Installing Ubuntu


---

## Setting up Ubuntu


--- 

## Training Your Model

