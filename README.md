# USBDROP                               
## A Simple USB Drop Attack aiming to exfiltrate browser passwords

A ‘USB drop attack’, also known as ‘USB Baiting’ is a commonly used social engineering attack whereby a USB stick containing malicious software is conveniently placed (dropped) where the target will likely find it. The attack relies on the curiosity of a target and seeks to entice them to insert the device into their pc in order to discover the contents or owner of the device. 

Once the victim picks up the device, it is highly probable that they will plug it into their system and open files or applications without much thought of security and the consequences of doing so. Thankfully, considerable progress has been made to defend against this type of attack, with operating systems and anti-virus software blocking known software and attack methods such as those which automatically execute payloads via autorun.inf files on USB sticks.

Taking into consideration that the autorun.inf method is no longer supported on operating systems above Windows 8,  the below two methods can be considered to perform this attack:

1. HID (Human Interface Device) spoofing

In this scenario, specialised hardware which looks like a normal USB drive fools a computer into thinking that it is another device such as a keyboard. When
plugged in, it starts to inject keystrokes without user interaction and compromises the victim’s computer. This attack automatically spawns a terminal, quickly injects commands and leaves little to see. It is therefore less obvious then a social engineering attack.

2. Social Engineering / Malicious Code via a Regular USB 

In this attack, a standard USB drive is configured with a malicious payload and the victim is tricked into plugging it into their computer and executing it. This can be performed via a number of methods, including scripts, password harvesting tools and macros.

Due to HID spoofing  requiring specialised hardware - such as HAK5’s USB rubber ducky or a Digispark Attiny85, the second option of using a standard USB device is the  method chowen for this scenario. As such, social engineering techniques will need to be employed in order to entice the victim to manually click a file on the USB and extract passwords from the browser. The tool, process and logic for the selected attack is outlined below.


## Tool Selection

The tool recomended for this task is the command line version of ‘WebBrowserPassView’ from Nirsoft (https://www.nirsoft.net/utils/web_browser_password.html). As long as passwords are stored in the browser, the tool is able to reveal passwords stored in most modern web browsers – including Internet Explorer (Version 4.0 - 11.0), Mozilla Firefox (All Versions), Google Chrome, Safari, and Opera. Upon retrieving passwords, these can be outputted to multiple file types, including text, html, csv and xml files – which can then be exfiltrated to the attacker.

## Process & Logic 

The rationale behind this USB drop attack is that the device will be placed in a location likely to be picked up by the victim and then inserted into their pc. Upon doing so, they will see a shortcut disguised as a text file (via a custom icon) named ‘Contact Details’ which points to a hidden batch file. Running the shortcut will execute the .bat script and perform the following in a minimised window:


- Execute WebBrowserPassView.exe, located in a hidden folder named ‘Tools’.
- Save extracted browser passwords to a text file in the hidden ‘Tools’ folder.
- Silently email the password file as an attachment to a Gmail account 
- Self-delete script to cover trace

Note: It is assumed that the system is vulnerable and not running Windows Defender or equivalent Antivirus software, as the tool is likely to be flagged.

In order to achieve the above, the following steps need to be taken:

1. Download and extract the Nirsoft browser command line password tools from https://www.nirsoft.net/protected_downloads/passreccommandline.zip.
2. Open the USB drive, create a folder named ‘Tool’ and copy ‘WebBrowserPassView.exe’ into the folder. Set this folder as ‘hidden’ in order to remove it from user view.
3. Copy the Contact.bat script to the root of the USB drive file attributes on it to ‘hidden’.
4. Right click the script and create a shortcut of it named ‘Contact Details’. Change the icon of this shortcut to one represanting a contact.
5. Set the script shortcut to run minimized (right click/properties). This will reduce the chance of the victim noticing anything being executed.
6. The victim simply needs to double click the ‘Contact Details’ shortcut and the whole process will run without the users’ knowledge.


# Attack results

Upon successful deployment, a text file containing browser passwords is saved to the ‘Tool’ directory and a copy sent to the configured email address in the script. Traces of the script and attachments are then auto deleted to cover tracks.
