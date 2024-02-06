# Dotfiles for Pop!_OS Development Workstation

This repository contains dotfiles and configuration files tailored for a Pop!_OS workstation environment. These dotfiles aim to automate the configuration process of various tools and applications.

## Usage

To use these dotfiles, follow these steps:

1. Clone this repository to your local machine:

    ```sh
    git clone https://github.com/ge3224/dotfiles-popos
    ```

2. Navigate to the cloned repository:

    ```sh  
    cd dotfiles-popos
    ```

3. Install Ansible if not already installed:

    ```sh 
    sudo apt install ansible
    ```
4. Run the main playbook to apply the dotfile configurations:

    ```sh
    ansible-playbook roles/main.yml -K
    ```
## Contributing

Contributions are welcome! If you have any suggestions, improvements, or new configurations to add, feel free to fork this repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License. Feel free to use, modify, and distribute the code as per the terms of the license.
