# Windows Repair Tools
This is an evolving collection of tools to help troubleshoot corrupt Windows installations. This happens more often than it should, and troubleshooting and repairing these issues can often be unnecessarily tedious and difficult.

I'll fill this in as I get a better idea of what I need. The goal is to create a collection of tools that allow one to quickly troubleshoot and resolve corrupt Windows installations. Very much a work in progress.

In terms of compatibility, I'm targeting PowerShell 5.1, since anything newer won't run in WinPE.

To use these files, click the **Download Zip** link from the **Code** drop-down button and extract the archive. Then import the module by running:

```powershell
Import-Module .\WindowsRepair
```

You'll need to run these commands from an elevated prompt.

## Export-WrInstallWim
The closer the repair image is to the broken image in terms of patch level, the easier it is for DISM to find an appropriate replacement for corrupted files. When using a Windows Install.wim file, the first step in that process is to export the image for the edition of Windows we need to repair. This image will serve a the baseline for applying update packages.

You can provide the path to either a Windows installation media ISO file or directly to the *install.wim* (or *install.esd*) file on an already mounted disc.

Optionally, you can provide the index number of the image you want to export. If you don't and multiple images are detected, you'll be prompted to choose.

Once an image is selected, a copy will be exported to a staging folder for patching.

Examples:

```powershell
Export-WrInstallWim -WimFilePath D:\sources\install.wim -ImageIndex 2

Export-WrInstallWim -InstallMediaIso downloads\WinSvr2019.iso
```

> **NOTE:** According to Microsoft's documentation on [choosing a repair source](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-a-windows-repair-source#choose-a-repair-source), they note you should always use RTM media rather than refresh media, given that the later can exlude older versions of files that may be needed.
>
> They neglect, however, to clearly define those terms. RTM is the original release, but what exactly is refresh media? And why bother providing two versions if one is less useful?
>
> If I download Windows Server 2019 from the Evaluation Center, for example, the file name in part reads *release_svc_refresh*. Does this mean the evaluation copy can't be used as source media? If so, what is the best way to get an appropriate ISO in a pinch?
>
> You can try the evaluation copy, but "results may vary" until I confirm otherwise. If I can find a clear answer, I'll update this documentation.
>
> If you need to repair a Windows client install, Microsoft provides ISO download pages:
>
> * [Windows 10](https://www.microsoft.com/en-us/software-download/windows10ISO)
> * [Windows 8.1](https://www.microsoft.com/en-us/software-download/windows8ISO)
> * [Windows 7](https://www.microsoft.com/en-us/software-download/windows7)
