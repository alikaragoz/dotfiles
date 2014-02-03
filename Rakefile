require 'rake'
require 'fileutils'

task :default => 'install'

# Global installation.
task :install  do
  Rake::Task["installation"].execute
  Rake::Task["install_homebrew"].execute
  Rake::Task["submodule_init"].execute
  Rake::Task["install_vundle"].execute
  Rake::Task["install_prezto"].execute
  Rake::Task["installed"].execute
end

task :install_homebrew do
  run %{which brew}
  unless $?.success?
    puts
    puts "======================================================"
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    run %{ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"}
  end

  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}
  puts
  puts "======================================================"
  puts "Installing Homebrew packages...There may be some warnings."
  puts "======================================================"
  run %{brew install zsh git tmux the_silver_searcher rbenv ruby-build}
  puts
  puts
end

# Submodules
task :submodule_init do
  puts
  puts "======================================================"
  puts "Downloading submodules."
  puts "======================================================"

  run %{
    cd $HOME/.dotfiles
    git submodule update --init --recursive
    git clean -df
  }
  puts
end

# Vundle
task :install_vundle do
  puts
  puts "======================================================"
  puts "Installing vundles."
  puts "======================================================"

  file_operation(Dir.glob('vim/vim*'), :copy)

  vundle_path = File.join('vim', 'bundle', 'vundle')
  unless File.exists?(vundle_path)
    run %{
      git clone https://github.com/gmarik/vundle.git #{vundle_path}
      vim +BundleInstall +qall
    }
  end
end

# Prezto
task :install_prezto do
  puts
  puts "======================================================"
  puts "Installing Prezto (ZSH Enhancements)."
  puts "======================================================"

  unless File.exists?(File.join(ENV['ZDOTDIR'] || ENV['HOME'], ".zprezto"))
    run %{ ln -nfs "$HOME/.dotfiles/zsh/prezto" "${ZDOTDIR:-$HOME}/.zprezto" }

    # The prezto runcoms are only going to be installed if zprezto has never been installed
    file_operation(Dir.glob('zsh/prezto/runcoms/z*'), :copy)
  end

  puts "Overriding some prezto configuration to enable additional modules."
  run %{ ln -nfs "$HOME/.dotfiles/zsh/zpreztorc.zsh" "${ZDOTDIR:-$HOME}/.zpreztorc" }
  run %{ ln -nfs "$HOME/.dotfiles/zsh/zshenv.zsh" "${ZDOTDIR:-$HOME}/.zshenv" }
  run %{ ln -nfs "$HOME/.dotfiles/zsh/zshrc.zsh" "${ZDOTDIR:-$HOME}/.zshrc" }

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
  puts
  puts "======================================================"
  puts "Installing Ai dotfiles."
  puts "======================================================"
  puts
end

# Installed
task :installed do
  puts
  puts "======================================================"
  puts "Please restart your terminal and vim."
  puts "======================================================"
  puts
end

private
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def file_operation(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if method == :symlink
      run %{ ln -nfs "#{source}" "#{target}" }
    else
      run %{ cp -f "#{source}" "#{target}" }
    end

    puts "=========================================================="
    puts
  end
end