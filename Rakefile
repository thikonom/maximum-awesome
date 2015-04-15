def apt_install(package, *options)
   sh "sudo apt-get install #{package} #{options.join ' '}"
end

def version_match?(requirement, version)
  # This is a hack, but it lets us avoid a gem dep for version checking.
  Gem::Dependency.new('', requirement).match?('', version)
end

def install_github_bundle(user, package)
  unless File.exist? File.expand_path("~/.vim/bundle/#{package}")
    sh "git clone https://github.com/#{user}/#{package} ~/.vim/bundle/#{package}"
  end
end

def install_autojump()
  unless File.exist? File.expand_path("./autojump")
    sh "git clone git@github.com:joelthelion/autojump.git"
  end
  path = File.expand_path("autojump")
  Dir.chdir(path) do
    sh %{./install.py}
  end
  line = "if test -f /home/thikonom/.autojump/share/autojump/autojump.fish; . /home/thikonom/.autojump/share/autojump/autojump.fish; end"
  system("echo '#{line}' >> ~/.config/fish/config/fish")
end

def install_ag()
    sh 'sudo apt-get install build-essential automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev'
    sh 'git clone https://github.com/ggreer/the_silver_searcher.git'
    Dir.chdir 'the_silver_searcher' do
      sh './build.sh'
      sh 'sudo make install'
    end
end

def install_fish()
  sh "sudo apt-add-repository ppa:fish-shell/release-2"
  sh "sudo apt-get update"
  sh "sudo apt-get install fish"
  system("chsh -s /usr/bin/fish")
  sh "mkdir -p ~/.config/fish"
  sh "touch ~/.config/fish/config.fish"
end

def install_virtualfish()
   apt_install('python-setuptools')
   sh "sudo easy_install pip"
   sh "sudo pip install virtualfish"
end

def install_solarized_yo()
  apt_install('dconf-cli')
  sh "git clone git@github.com:Anthony25/gnome-terminal-colors-solarized.git solarized_theme"
  Dir.chdir 'solarized_theme' do
    sh './install.sh'
  end
end

def install_inconsolata()
  apt_install('fonts-inconsolata')
end

def step(description)
  description = "-- #{description} "
  description = description.ljust(80, '-')
  puts
  puts "\e[32m#{description}\e[0m"
end

def app_path(name)
  path = "/Applications/#{name}.app"
  ["~#{path}", path].each do |full_path|
    return full_path if File.directory?(full_path)
  end

  return nil
end

def app?(name)
  return !app_path(name).nil?
end

def get_backup_path(path)
  number = 1
  backup_path = "#{path}.bak"
  loop do
    if number > 1
      backup_path = "#{backup_path}#{number}"
    end
    if File.exists?(backup_path) || File.symlink?(backup_path)
      number += 1
      next
    end
    break
  end
  backup_path
end

def link_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.exists?(symlink_path) || File.symlink?(symlink_path)
    if File.symlink?(symlink_path)
      symlink_points_to_path = File.readlink(symlink_path)
      return if symlink_points_to_path == original_path
      # Symlinks can't just be moved like regular files. Recreate old one, and
      # remove it.
      ln_s symlink_points_to_path, get_backup_path(symlink_path), :verbose => true
      rm symlink_path
    else
      # Never move user's files without creating backups first
      mv symlink_path, get_backup_path(symlink_path), :verbose => true
    end
  end
  ln_s original_path, symlink_path, :verbose => true
end

def unlink_file(original_filename, symlink_filename)
  original_path = File.expand_path(original_filename)
  symlink_path = File.expand_path(symlink_filename)
  if File.symlink?(symlink_path)
    symlink_points_to_path = File.readlink(symlink_path)
    if symlink_points_to_path == original_path
      # the symlink is installed, so we should uninstall it
      rm_f symlink_path, :verbose => true
      backups = Dir["#{symlink_path}*.bak"]
      case backups.size
      when 0
        # nothing to do
      when 1
        mv backups.first, symlink_path, :verbose => true
      else
        $stderr.puts "found #{backups.size} backups for #{symlink_path}, please restore the one you want."
      end
    else
      $stderr.puts "#{symlink_path} does not point to #{original_path}, skipping."
    end
  else
    $stderr.puts "#{symlink_path} is not a symlink, skipping."
  end
end

def add_git_email()
  print 'Please enter your global git email:'
  git_email = gets.chomp
  sh "echo '    email = #{git_email}' >> ~/.gitconfig"
end

namespace :install do

  desc 'Install ctags'
  task :ctags do
    step 'ctags'
    apt_install 'ctags'
  end

  desc 'Install Vim'
  task :vim_love do
    step 'vim love'
    apt_install 'vim'
  end

  desc 'Install tmux'
  task :tmux do
    step 'tmux'
    apt_install 'tmux'
  end

  desc 'Install Vundle'
  task :vundle do
    step 'vundle'
    install_github_bundle 'gmarik','vundle'
    sh '/usr/bin/vim -c "BundleInstall" -c "q" -c "q"'
  end

  desc 'Install The Silver Searcher'
  task :the_silver_searcher do
    step 'the_silver_searcher'
    install_ag
  end

  desc 'Install the fish shell'
  task :fish do
    step 'fish'
    install_fish
  end

  desc 'Install virtualenv'
  task :virtualfish do
    step 'virtualfish'
    install_virtualfish
  end

  desc 'Install autojump'
  task :autojump do
    step 'autojump'
    install_autojump
  end

  desc 'Install solarized yo!'
  task :solarized do
    step 'solarized'
    install_solarized_yo
  end

  desc 'Install inconsolata'
  task :inconsolata do
    step 'inconsolata'
    install_inconsolata
  end
end

def filemap(map)
  map.inject({}) do |result, (key, value)|
    result[File.expand_path(key)] = File.expand_path(value)
    result
  end.freeze
end

COPIED_FILES = filemap(
  'vimrc.local'         => '~/.vimrc.local',
  'vimrc.bundles.local' => '~/.vimrc.bundles.local',
  'tmux.conf.local'     => '~/.tmux.conf.local'
)

LINKED_FILES = filemap(
  'vim'                  => '~/.vim',
  'tmux.conf'            => '~/.tmux.conf',
  'vimrc'                => '~/.vimrc',
  'vimrc.bundles'        => '~/.vimrc.bundles',
  'gitconfig'            => '~/.gitconfig',
  'gitignore_global'     => '~/.gitignore_global',
  'config.fish'          => '~/.config.fish'
)

desc 'Install these config files.'
task :install do
  Rake::Task['install:ctags'].invoke
  Rake::Task['install:vim_love'].invoke
  Rake::Task['install:tmux'].invoke
  Rake::Task['install:the_silver_searcher'].invoke
  Rake::Task['install:fish'].invoke
  Rake::Task['install:virtualfish'].invoke
  Rake::Task['install:autojump'].invoke
  Rake::Task['install:solarized'].invoke
  Rake::Task['install:inconsolata'].invoke

  step 'symlink'

  LINKED_FILES.each do |orig, link|
    link_file orig, link
  end

  COPIED_FILES.each do |orig, copy|
    cp orig, copy, :verbose => true unless File.exist?(copy)
  end

  # Install Vundle and bundles
  Rake::Task['install:vundle'].invoke

  add_git_email()

  puts
  puts "  Enjoy!"
  puts
end

desc 'Uninstall these config files.'
task :uninstall do
  step 'un-symlink'

  # un-symlink files that still point to the installed locations
  LINKED_FILES.each do |orig, link|
    unlink_file orig, link
  end

  # delete unchanged copied files
  COPIED_FILES.each do |orig, copy|
    rm_f copy, :verbose => true if File.read(orig) == File.read(copy)
  end

end

task :default => :install
