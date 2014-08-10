require "spec_helper"

describe ".check_mode" do
  it "returns expected value" do
    class Ftp
      def chdir(target)
        "/httpdocs"
      end
      def list
        [
          "drwxr-xr-x  25 owner_name group_name      4096 Aug  3 19:57 .", 
          "drwxr-xr-x  13 root     root         4096 Oct 22  2012 ..",
          "-rw-r--r--   1 owner_name group_name      26482 Jul 19  2010 index.php",
          "drwxr-xr-x   4 owner_name group_name       4096 Oct 17  2010 dir"
        ]
      end
      def pwd
        "/httpdocs"
      end
    end

    allow(Ftpspec).to receive(:get_ftp) { Ftp.new }
    actual = Ftpspec::Commands.check_mode("/httpdocs/index.php", 644)
    expect(actual).to be true
  end
end
