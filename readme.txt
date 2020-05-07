1）操作系统环境
ubuntu 16.04
2）安装perl
sudo apt-get install -y perl
3）查找系统perl模块位置
sudo find / -name perl
找到perl的模块路径
/usr/src/linux-headers-4.4.0-87/tools/perf/scripts/perl
/usr/share/lintian/overrides/perl
/usr/share/perl
/usr/share/doc/perl
/usr/share/bash-completion/completions/perl
/usr/share/bash-completion/helpers/perl
/usr/bin/perl
/usr/lib/x86_64-linux-gnu/perl
/etc/perl
/etc/apparmor.d/abstractions/perl
查看具体的版本路径
ls /usr/share/perl
发现最终路径为：
/usr/share/perl/5.22.1
4）执行模块安装：
sudo tar -zxvf awdb.tar.gz
sudo cp -r ./awdb/* /usr/share/perl/5.22.1/
修改test.pl中的文件路径:
#!/usr/bin/env perl
use strict;
use warnings;
use feature qw( say );

use Data::Printer;
use AW::DB::Reader;
use Net::Works::Address;
my $reader = AW::DB::Reader->new( file => './IP_city_single_WGS84_awdb.awdb' );
my $record = $reader->record_for_address('166.111.4.100');
say np $record;

测试代码：
perl test.pl
控制台输出：
\ {
    accuracy     "城市",
    areacode     "CN",
    asnumber     4538,
    continent    "亚洲",
    country      "中国",
    isp          "China Education and Research Network Center",
    multiAreas   [
        [0] {
            city     "北京市",
            latwgs   39.902798,
            lngwgs   116.401159,
            prov     "北京市",
            radius   105.2321
        }
    ],
    owner        "清华大学",
    source       "数据挖掘",
    timezone     "UTC+8",
    zipcode      100005
}

常见问题：
Could not find a suitable AW::DB::Reader implementation: Can't locate Math/Int64.pm in @INC (you may need to install the Math::Int64 module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.22.1 /usr/local/share/perl/5.22.1 /usr/lib/x86_64-linux-gnu/perl5/5.22 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl/5.22 /usr/share/perl/5.22 /usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base .) at /usr/share/perl/5.22/AW/DB/Reader/XS.pm line 12.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/AW/DB/Reader/XS.pm line 12.
Compilation failed in require at /usr/share/perl5/Module/Runtime.pm line 317.
List::Util version 1.45 required--this is only version 1.41 at /usr/share/perl/5.22/List/AllUtils.pm line 8.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/List/AllUtils.pm line 8.
Compilation failed in require at /usr/share/perl/5.22/AW/DB/Types.pm line 10.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/AW/DB/Types.pm line 10.
Compilation failed in require at /usr/share/perl/5.22/AW/DB/Reader/PP.pm line 12.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/AW/DB/Reader/PP.pm line 12.
Compilation failed in require at /usr/share/perl5/Module/Runtime.pm line 317.
 at /usr/share/perl/5.22/AW/DB/Reader.pm line 22.
Compilation failed in require at test.pl line 8.
BEGIN failed--compilation aborted at test.pl line 8.
解决：
sudo apt install -y gcc g++ make cpanminus
sudo cpanm Math::Int64 Math::Int128

Could not find a suitable AW::DB::Reader implementation: List::Util version 1.45 required--this is only version 1.41 at /usr/share/perl/5.22/List/AllUtils.pm line 8.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/List/AllUtils.pm line 8.
Compilation failed in require at /usr/share/perl/5.22/AW/DB/Types.pm line 10.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/AW/DB/Types.pm line 10.
Compilation failed in require at /usr/share/perl/5.22/AW/DB/Metadata.pm line 10.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/AW/DB/Metadata.pm line 10.
Compilation failed in require at /usr/share/perl/5.22/AW/DB/Reader/XS.pm line 15.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/AW/DB/Reader/XS.pm line 15.
Compilation failed in require at /usr/share/perl5/Module/Runtime.pm line 317.
Attempt to reload AW/DB/Types.pm aborted.
Compilation failed in require at /usr/share/perl/5.22/AW/DB/Reader/PP.pm line 12.
BEGIN failed--compilation aborted at /usr/share/perl/5.22/AW/DB/Reader/PP.pm line 12.
Compilation failed in require at /usr/share/perl5/Module/Runtime.pm line 317.
 at /usr/share/perl/5.22/AW/DB/Reader.pm line 22.
Compilation failed in require at test.pl line 8.
BEGIN failed--compilation aborted at test.pl line 8.
解决：
sudo cpanm List::Util

Can't locate NetAddr/IP.pm in @INC (you may need to install the NetAddr::IP module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.22.1 /usr/local/share/perl/5.22.1 /usr/lib/x86_64-linux-gnu/perl5/5.22 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl/5.22 /usr/share/perl/5.22 /usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base .) at /usr/share/perl/5.22/Data/Validate/IP.pm line 10.
解决：
sudo cpanm NetAddr::IP
（比较慢，约5分钟）