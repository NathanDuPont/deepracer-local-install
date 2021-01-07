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

This will take you through installation. **Installation will require you to restart your computer if you don't currently have WSL installed**. Please follow the prompts in the install scripts, and re-run the script using the steps above as the prompts say.

---

## Installing Ubuntu

If the script failed to install Ubuntu, or you already have WSL2 and want to install Ubuntu yourself, you can find it in the **Windows Store**. 

Open up the Windows Store, and search for "Ubuntu 20.04". You should see the following as one of the options:

![Ubuntu Listing in Windows Store](/img/ubuntu-windows-store.png)

Download the distribution using the blue button in the top right. Once downloaded and installed, the button in the top right will turn to "Launch". Either press this, or press [Windows] + [S], search for "Ubuntu", and run the Ubuntu 20.04 application.

---

## Setting up Ubuntu

Once installed, run the Ubuntu distribution (as described above). If this is the first time you are opening the distribution, it will need to configure itself. It will ask you for a username and password; enter these and **remember** them for later. You will need to enter this password (as the root/sudo password) later.

Once the distribution has completed setup, your bash window should look something like this (of course, with your name and computer name):

![Blank Ubuntu Bash Line](/img/ubuntu-shell.png)

From here, run the following commands (copy and paste all at once):

`mkdir temp; cd temp; git clone https://github.com/NathanDuPont/deepracer-local-install.git; cd ./deepracer-local-install; chmod +rwx *; sudo ./linux-install.sh`

--- 

## Configuring Docker (Windows only)

**Steps for WSL 1 and 2**

For Docker to work correctly with WSL, there are a few settings you need to change. First, press [Windows] + [S] and search for "Docker Desktop". Run this and let it start up.

If Docker Desktop doesn't open up in 5-10 seconds, it is still starting up. Wait a minute, search for the application again, and run it as described above. This should open up the Docker Desktop window.

In the top of the window, press the settings (gear) icon. You should see a screen like this:

![Docker Settings Window](/img/docker-settings-1.png)

For WSL 1, make sure the second option is checked (Expose daemon on port). For WSL 2, make sure the second and third options are checked (Expose daemon on port & Use the WSL 2 based engine).

Now, open up the menu under *Resources*>*WSL Integration*.

![Docker WSL Settings](/img/docker-settings-2.png)

Make sure "Enable Integration with my default WSL distro", is checked, along with making sure the toggle by Ubuntu-20.04. 

Once all of these settings are configured, press "Apply & Restart" in the bottom right.

---

## Setting up your Environment

There are several ways to set up your development environment. If using Windows, you can either edit the files by issuing a "nano" command, followed by the name of the file you wish to edit:

`nano reward.py`

This will edit the file "reward.py" found in your current directory.

The **recommended** environment is *Visual Studio Code* ([download here](https://code.visualstudio.com/)), with the *Remote-WSL* extension (search for ms-vscode-remote.remote-wsl in the extensions menu). While this guide will not detail the setup, [this guide from Microsoft](https://code.visualstudio.com/docs/remote/wsl) explains all details surrounding the environment setup. The primary positive of using VSCode is that it allows you to see your entire file directory easily, with an integrated bash shell for WSL.

---

## Training Your Model

To start up the server, first enter the folder that deepracer-local was installed into, with the following command:

`cd ~/deepracer/deepracer-local/`

This should take you into the install directory of the deepracer files. For more information on the repository, [visit this link](https://github.com/NathanDuPont/deepracer-local) for a full description. 

The most important steps of the program:

**Configuring your Reward Function (and model)**

In the following directory, you will find files pertaining to the model:

`~/deepracer/deepracer-local/data/minio/bucket/custom_files`

*model_metadata.json*:
This contains the basic parameters for the vehicle. Do not change these, as we will be working with the default parameters with the final models.

*reward.py*:
This contains the reward function for the vehicle. Write your code here! Writing a better reward function can make it easier for the car to stay on track, and make the model adapt to the road faster.

*training_params.yaml*:
This file is used for configuration for the training containers. Do not change this file, as we will be using the default file when training models.

NOTE: all of the following commands require being in the **/deepracer/deepracer-local** directory!

**Starting the Model**

Run the following command to start training:

`sudo ./start-training.sh`

To view the model while training, open up a web browser and go to the following URL:

`http://localhost:8888`

You will see a screen similar to this once the server has started (it may take a minute or two to load):

![DeepRacer ROS Topics](/img/ros-topics.png)

We will mainly be using the **/racecar/deepracer/kvs_stream** option, but feel free to look around the other camera views. 

The model is trained by being placed randomly on the track, and using feedback from the reward function to stay on the track for a given amount of time. After this allotted time (random), the car is relocated and given more time to drive. A better model is on that is able to stay on the track for a longer period of time.

**Stopping the Model**

To stop the model, run the following command:

`sudo ./stop-training.sh`

As noted in the actual DeepRacer repository, only stop the model when the camera view specified above says **"Training"**. This will make sure that all of the model parameters are saved correctly.

**Exporting a Model**

To submit your final model, we need a copy of your reward function. When you are ready to submit, copy the **reward.py** file and submit that.
