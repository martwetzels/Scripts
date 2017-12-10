# Bash script for installing TUe Printers on MacOS

After pulling the repository, run the following command:

```
chmod +x installPrinter.sh
./installPrinter.sh
```

This will make the script executable and run it.
If no drivers have been installed, the driver in the repo is used.

If it errors to not permitted

```
xattr -d com.apple.quarantine /installPrinter.sh
```
