# Link-size-checker

A lightweight Bash utility that calculates the individual and total file sizes of a list of URLs without downloading them.

---

## Overview

**link-size-checker** is a command-line tool designed to estimate storage requirements for remote assets. By sending HTTP HEAD requests via `curl`, the script extracts the `Content-Length` from the server headers. This allows you to see the size of files in Megabytes (MB) and Gigabytes (GB) instantly, saving time and bandwidth.

## Features

- **Bulk Analysis:** Reads URLs line-by-line from a text file.
- **Header-Only:** Retrieves metadata without downloading the actual file content.
- **Human-Readable Output:** Automatically converts bytes into MB and GB using `awk`.
- **Total Calculation:** Provides a grand total of all reachable files at the end of the run.
- **Smart Cleaning:** Handles URLs wrapped in brackets `[]` and strips URL query parameters for cleaner file names.

## Prerequisites

Ensure you have the following installed on your system:

- **Bash** (Standard on Linux/macOS)
- **curl** (To fetch HTTP headers)
- **awk** (To perform mathematical conversions)

## Installation & Usage

1.  **Clone the repository:**

    ```bash
    git clone [https://github.com/Kim-Tsok/link-size-checker.git](https://github.com/Kim-Tsok/Link-size-checker.git)
    cd Link-size-checker
    ```

2.  **Add your links:**
    Add your URLs (one per line) to the file named `links.txt` in the root directory .

3.  **Set permissions:**

    ```bash
    chmod +x run.sh
    ```

4.  **Run the script:**
    ```bash
    ./run.sh
    ```

## Example Output

| File             | MB          | GB       |
| :--------------- | :---------- | :------- |
| ubuntu-22.04.iso | 3584.00     | 3.50     |
| data-backup.zip  | 512.50      | 0.50     |
| broken-link.exe  | ???         | ???      |
| **TOTAL**        | **4096.50** | **4.00** |

## Troubleshooting

If a file displays `???`, it usually means:

1.  **Broken Link:** The URL is returning a 404 Not Found error.
2.  **Missing Header:** The server does not provide a `Content-Length` header (common with dynamic or streamed content).
3.  **Permissions:** The server is blocking HEAD requests or requires authentication.

## License

This project is open-source and available under the [MIT License](LICENSE).
