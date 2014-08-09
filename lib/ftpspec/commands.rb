module Ftpspec
  class Commands

    def self.check_mode(target, expected)
      ftp = Ftpspec.get_ftp
      ftp.chdir File.dirname(target)
      ftp.list.each do |file|
        part = file.split(" ")
        if part[8] != "." && part[8] != ".." then
          current_path = ftp.pwd
          filemode = part[0]
          filename = current_path + "/" + part[8]
          if filename == target then
            return Ftpspec::Utils.convert_to_octal(filemode).to_i == expected          
          end
        end
      end
      return false
    end

    def self.check_file(target)
      ftp = Ftpspec.get_ftp
      ftp.chdir File.dirname(target)
      ftp.list.each do |file|
        part = file.split(" ")
        if part[8] != "." && part[8] != ".." then
          current_path = ftp.pwd
          filemode = part[0]
          filename = current_path + "/" + part[8]
          if filename == target then
            return filemode[0] == "-"
          end
        end
      end
      return false
    end

    def self.check_directory(target)
      ftp = Ftpspec.get_ftp
      ftp.chdir File.dirname(target)
      ftp.list.each do |file|
        part = file.split(" ")
        if part[8] != "." && part[8] != ".." then
          current_path = ftp.pwd
          filemode = part[0]
          filename = current_path + "/" + part[8]
          if filename == target then
            return filemode[0] == "d"
          end
        end
      end
      return false
    end

    def self.check_owner(target, expected)
      ftp = Ftpspec.get_ftp
      ftp.chdir File.dirname(target)
      ftp.list.each do |file|
        part = file.split(" ")
        if part[8] != "." && part[8] != ".." then
          current_path = ftp.pwd
          filemode = part[0]
          owner = part[2]
          filename = current_path + "/" + part[8]
          if filename == target then
            return owner == expected
          end
        end
      end
      return false
    end

    def self.check_group(target, expected)
      ftp = Ftpspec.get_ftp
      ftp.chdir File.dirname(target)
      ftp.list.each do |file|
        part = file.split(" ")
        if part[8] != "." && part[8] != ".." then
          current_path = ftp.pwd
          filemode = part[0]
          group = part[3]
          filename = current_path + "/" + part[8]
          if filename == target then
            return group == expected
          end
        end
      end
      return false
    end
  end
end
