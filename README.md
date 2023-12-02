# Linux From Scratch (LFS) Build Script

This repository contains a simple bash script (`lfs.sh`) to automate the process of building a basic Linux From Scratch (LFS) system.

## Prerequisites

Before running the script, make sure you have the following prerequisites:

- A host system with a working Linux installation.
- Basic development tools (GCC, Binutils, etc.) installed on the host.
- Sufficient disk space for the LFS build.

## Usage

1. Clone this repository to your host system:

    ```bash
    git clone https://github.com/pygeniusgithub/lfs-build.git
    cd lfs-build
    ```

2. Make the script executable:

    ```bash
    chmod +x lfs.sh
    ```

3. Run the script with:

    ```bash
    ./lfs.sh
    ```

4. Follow the on-screen instructions to proceed with the LFS build.

## Important Notes

- This script assumes a basic LFS setup. Modify it according to your specific needs.
- Ensure that you understand the commands in the script before running it.
- This script may need customization based on your host system and preferences.

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
