<#
.notes 
  * original author mark berry (c) 2015 mcb systems all rights reserved free for personal or commercial use may not be sold
  * modified for use in aegis v1.14+ by https://voat.co/u/thepower on 02.23.2016
#>
$kbnumbers=971033,2882822,2902907,2922324,2952664,2976978,2977759,2990214,3012973,3014460,3015249,3021917,3022345,3035583,3042058,3044374,3046480,3050265,3050267,3064683,3065987,3065988,3068708,3072318,3074677,3075249,3075851,3075853,3080149,3081437,3081454,3081954,3083324,3083325,3083710,3083711,3086255,3088195,3090045,3093983,3102810,3102812,3112343,3112336,3123862,3135445,3135449
""
""
"* hide updates (this may take a while, be patient) ..."
""
$x=0
try {
  $updatesession = new-object -comobject microsoft.update.session
  $updatesearcher = $updatesession.createupdatesearcher()
  $updatesearcher.includepotentiallysupersededupdates = $true
  $searchresult = $updatesearcher.search("isinstalled=0")
  foreach ($kbnumber in $kbnumbers) {
    [boolean]$kblisted = $false
    foreach ($update in $searchresult.updates) {
      foreach ($kbarticleid in $update.kbarticleids) {
        if ($kbarticleid -eq $kbnumber) {
          $kblisted = $true
          if ($update.ishidden -eq $false) {
            $x=1
            write-host " - hide kb$kbnumber"
            $update.ishidden = $true     
          }
        }
      }
    }
  }
  $objautoupdatesettings = (new-object -comobject "microsoft.update.autoupdate").settings
  $objsysinfo = new-object -comobject "microsoft.update.systeminfo"
}
catch {
}
if ($x -eq 0) {
  " - no updates needed to be hidden"
}