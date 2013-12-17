class { "wozbe::profile::common": }
class { "wozbe::profile::symfony2": 
    dist_conf => { 'date.timezone' => 'Europe/Paris' } 
}
