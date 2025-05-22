🛡️ tlsx-wrapper
Automation script for extracting Subject Alternative Names (SANs) using tlsx with support for lists and automatic deduplication!
✅ Description
tlsx-wrapper is a Shell script designed to streamline the automated collection of TLS certificate information using the tlsx tool.
It enables quick and efficient extraction of Subject Alternative Names (SANs) from SSL/TLS certificates, saving the results without duplicates.

The script supports two input modes:

-u: To analyze a single URL.

-l: To analyze a file containing multiple subdomains.

✅ Features
🔍 Automatically checks for required tools (go, tlsx, jq, anew).

🛠️ If a tool is missing, it prompts the user to install it.

📦 Installs and copies tools to /usr/local/bin for easy access.

🗃️ Supports single URL or subdomain list inputs.

🚫 Automatically deduplicates results using anew by tomnomnom.

📝 Saves all results to resultados.txt.

✅ Requirements
Linux system or compatible (e.g., WSL).

Go installed and configured.

sudo permissions to install dependencies.

✅ Tools Used
Tool	Purpose
tlsx	TLS certificate scanner with JSON output.
jq	JSON parsing and manipulation.
anew	Efficient deduplication of entries.
go	Required to install tlsx and anew.

