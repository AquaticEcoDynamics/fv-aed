# Although VS-2019 is already installed it's missing some parts needed, so we do it anyway
curl -SL --ssl-no-revoke --output vs_community.exe https://aka.ms/vs/16/release/vs_community.exe
./vs_community.exe --quiet --norestart --wait --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended
#
curl -SL --ssl-no-revoke --output w_fortran-compiler_p_2023.0.0.25579_offline.exe https://registrationcenter-download.intel.com/akdlm/irc_nas/19107/w_fortran-compiler_p_2023.0.0.25579_offline.exe
mkdir tmp
./w_fortran-compiler_p_2023.0.0.25579_offline.exe -s -f tmp -a --silent --cli --action install --eula accept

