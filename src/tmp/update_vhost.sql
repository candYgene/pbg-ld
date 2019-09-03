-- /dav
DB.DBA.VHOST_REMOVE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/DAV'
);

DB.DBA.VHOST_DEFINE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/conductor',
	 ppath=>'/DAV/DAV/',
	 is_dav=>1,
	 is_brws=>1,
	 def_page=>'main_tabs.vspx',
	 sec=>'SSL',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 auth_opts=>vector ('https_key', 'db:https_key_localhost', 'https_cert', 'db:https_key_localhost', 'https_verify', 3, 'https_cv_depth', 10),
	 opts=>vector ('browse_sheet', ''),
	 is_default_host=>0
);

-- /conductor
DB.DBA.VHOST_REMOVE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/conductor'
);

DB.DBA.VHOST_DEFINE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/conductor',
	 ppath=>'/DAV/VAD/conductor/',
	 is_dav=>1,
	 is_brws=>1,
	 def_page=>'main_tabs.vspx',
	 sec=>'SSL',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 auth_opts=>vector ('https_key', 'db:https_key_localhost', 'https_cert', 'db:https_key_localhost', 'https_verify', 3, 'https_cv_depth', 10),
	 opts=>vector ('browse_sheet', ''),
	 is_default_host=>0
);

-- /fct
DB.DBA.VHOST_REMOVE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/fct'
);

DB.DBA.VHOST_DEFINE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/fct',
	 ppath=>'/DAV/VAD/fct/',
	 is_dav=>1,
	 is_brws=>0,
	 def_page=>'facet.vsp',
	 sec=>'SSL',
	 vsp_user=>'SPARQL',
	 ses_vars=>0,
	 auth_opts=>vector ('https_key', 'db:https_key_localhost', 'https_cert', 'db:https_key_localhost', 'https_verify', 3, 'https_cv_depth', 10),
	 opts=>vector ('browse_sheet', ''),
	 is_default_host=>0
);

-- /sparql
DB.DBA.VHOST_REMOVE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/sparql'
);

DB.DBA.VHOST_DEFINE (
	 lhost=>':443',
	 vhost=>'localhost',
	 lpath=>'/sparql',
	 ppath=>'/!sparql/',
	 is_dav=>1,
	 is_brws=>0,
	 def_page=>'',
	 sec=>'SSL',
	 vsp_user=>'dba',
	 ses_vars=>0,
	 auth_opts=>vector ('https_key', 'db:https_key_localhost', 'https_cert', 'db:https_key_localhost', 'https_verify', 3, 'https_cv_depth', 10),
	 opts=>vector ('browse_sheet', '', 'noinherit', 'yes'),
	 is_default_host=>0
);


