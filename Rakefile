require 'rake'
require 'fileutils'

task :default => 'install'

# Global installation.
task :install  do
  Rake::Task["installation"].execute
  Rake::Task["submodule_init"].execute
  Rake::Task["install_vundle"].execute
  Rake::Task["install_prezto"].execute
  Rake::Task["installed"].execute
end

# Submodules
task :submodule_init do
  puts "======================================================"
  puts "Downloading submodules."
  puts "======================================================"

  run %{
    cd $HOME/.dotfiles
    git submodule update --recursive
    git clean -df
  }
  puts
end

# Vundle
task :install_vundle do
  puts "======================================================"
  puts "Installing vundles."
  puts "======================================================"

  vundle_path = File.join('vim', 'vundle')
  unless File.exists?(vundle_path)
    run %{
      git clone https://github.com/gmarik/vundle.git #{vundle_path}
    }
  end
end

# Prezto
task :install_prezto do
  puts "======================================================"
  puts "Installing Prezto (ZSH Enhancements)."
  puts "======================================================"

  unless File.exists?(File.join(ENV['ZDOTDIR'] || ENV['HOME'], ".zprezto"))
    run %{ ln -nfs "$HOME/.dotfiles/prezto" "${ZDOTDIR:-$HOME}/.zprezto" }

    # The prezto runcoms are only going to be installed if zprezto has never been installed
    file_operation(Dir.glob('zsh/prezto/runcoms/z*'), :copy)
  end

  puts "Overriding prezto ~/.zpreztorc with Ai zpreztorc to enable additional modules."
  run %{ ln -nfs "$HOME/.dotfiles/zsh/zpreztorc.zsh" "${ZDOTDIR:-$HOME}/.zpreztorc" }

  if ENV["SHELL"].include? 'zsh' then
    puts "Zsh is already configured as your shell of choice. Restart your session to load the new settings"
  else
    puts "Setting zsh as your default shell"
    if File.exists?("/usr/local/bin/zsh")
      if File.readlines("/private/etc/shells").grep("/usr/local/bin/zsh").empty?
        puts "Adding zsh to standard shell list"
        run %{ echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells }
      end
      run %{ chsh -s /usr/local/bin/zsh }
    else
      run %{ chsh -s /bin/zsh }
    end
  end
end

# Installation
task :installation do
  puts ""
  puts "      ___                   "
  puts "     /\  \                  "
  puts "    /::\  \       ___       "
  puts "   /:/\:\  \     /\__\      "
  puts "  /:/ /::\  \   /:/__/      "
  puts " /:/_/:/\:\__\ /::\  \      "
  puts " \:\/:/  \/__/ \/\:\  \__   "
  puts "  \::/__/       ~~\:\/\__\\ "
  puts "   \:\  \          \::/  /  "
  puts "    \:\__\         /:/  /   "
  puts "     \/__/         \/__/    "
end

# Installed
task :installed do
  puts "Please restart your terminal and vim."
end

private
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end