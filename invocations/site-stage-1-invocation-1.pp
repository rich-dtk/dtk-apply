$extlookup_datadir = '/etc/puppet/manifests/extdata'
$extlookup_precedence = ['common']
sinatra::app {"hello-world": app_port => "4567"}
