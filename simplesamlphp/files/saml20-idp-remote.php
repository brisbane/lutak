<?php

$metadata['urn:geant:edugain:component:be:aaieduhr:aaiedu.hr'] = array (
	'metadata-set' => 'saml20-idp-remote',
	'entityid' => 'urn:geant:edugain:component:be:aaieduhr:aaiedu.hr',
	'SingleSignOnService' => 'https://login.aaiedu.hr/sso/saml2/idp/SSOService.php',
	'SingleLogoutService' => 'https://login.aaiedu.hr/sso/saml2/idp/SingleLogoutService.php',
	'certData' => 'MIIEbDCCA1SgAwIBAgICAVYwDQYJKoZIhvcNAQEFBQAwQTETMBEGCgmSJomT8ixkARkTA25ldDEVMBMGCgmSJomT8ixkARkTBWdlYW50MRMwEQYDVQQDEwplZHVHQUlOU0NBMB4XDTEwMDYxMDA3NTk1NloXDTE4MDExNDA3NTk1NlowWTETMBEGCgmSJomT8ixkARkWA25ldDEVMBMGCgmSJomT8ixkARkWBWdlYW50MREwDwYDVQQKEwhBQUlFZHVIcjEYMBYGA1UEAxMPbG9naW4uYWFpZWR1LmhyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxSGZkVlXr7xZYvilQxqXfxinRUuKPJMVrrOXo33P5Y7PXZiNRiMldtAyD3gQpcPWY68HrTZWspypX6oLRKRIlRC7Nj4/E6Bwn+pD/TqnN8UwL5SuDm+kp7z/zHXYGfmalIzibOHpPlmV39PcObdPE02wtrxV3WtmZjakzD8vZwnRjwcS3jbcHgwmEnzcAcMrrXtJ4A5G5OlgE7A3U5cCttxd3Y8w3u9meZWAxsb9AzrWGwYUsH1bbStVQqXFZHH5U9VIs8iyQSfHCdV2jEN46nZkwbNVPnIMzQ3eaZrZ4JRth1BUdpNnbvv2mZH7YPbdLz2vWSrBpFfubwuxJHrrEQIDAQABo4IBVDCCAVAwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQU3UDcH284PfxY0A2gvZ7CGfclywIwHwYDVR0jBBgwFoAUiw+PJ4DSk9dGXZGEuy6YYq4E8dIwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjB9BgNVHREEdjB0gg9sb2dpbi5hYWllZHUuaHKGYWh0dHBzOi8vcmVnaXN0cnkuZWR1Z2Fpbi5vcmcvcmVzb2x2ZXI/dXJuPXVybjpnZWFudDplZHVnYWluOmNvbXBvbmVudDpiZTphYWllZHVocjpsb2dpbi5hYWllZHUuaHIwNQYDVR0fBC4wLDAqoCigJoYkaHR0cDovL3NjYS5lZHVnYWluLm9yZy9jcmwvY2FjcmwuZGVyMBsGA1UdIAQUMBIwEAYOKwYBBAGB1H4BDAIAAAQwDQYJKoZIhvcNAQEFBQADggEBAHvccCTPvtBVhBUJA8TZEAhOhctLbafP9vE2BDEuPy7cQLujli9mnocpIthwZ4JmRp2xZeTki+vetpikyc192o4d6iUrYVorY//uow3YUifsSDIN2VNfZvjs0lDAzfdTfXMvDugg8hEoEhOhr/yP6FGalM1nhvxauD4jwv6rgTuKPcNWDvFV6LVCxO0m3Mfk5pSlndFE9SXrQFC1dyXRcU1KqvMjjbZ0idKEpe7wMwIgWNGadqKCtBzF1GLkZQSsgiQUIVD3YG6OYBHzi6+/Shl3oueoMGWa8NQdycPHiz0qBS3CuCVwpJAoGymxJqoyWVkyKcrsYpwFgNq0PoAhN78=',
	'NameIDFormat' => 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient',
);

$metadata['https://login.aaiedu.hr/proxy/saml2/idp/metadata.php'] = array (
	'metadata-set' => 'saml20-idp-remote',
	'entityid' => 'https://login.aaiedu.hr/proxy/saml2/idp/metadata.php',
	'SingleSignOnService' => array (
		0 => array (
			'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect',
			'Location' => 'https://login.aaiedu.hr/proxy/saml2/idp/SSOService.php'
		),
	),
	'SingleLogoutService' => 'https://login.aaiedu.hr/proxy/saml2/idp/SingleLogoutService.php',
	'certData' => 'MIIEbDCCA1SgAwIBAgICAVYwDQYJKoZIhvcNAQEFBQAwQTETMBEGCgmSJomT8ixkARkTA25ldDEVMBMGCgmSJomT8ixkARkTBWdlYW50MRMwEQYDVQQDEwplZHVHQUlOU0NBMB4XDTEwMDYxMDA3NTk1NloXDTE4MDExNDA3NTk1NlowWTETMBEGCgmSJomT8ixkARkWA25ldDEVMBMGCgmSJomT8ixkARkWBWdlYW50MREwDwYDVQQKEwhBQUlFZHVIcjEYMBYGA1UEAxMPbG9naW4uYWFpZWR1LmhyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxSGZkVlXr7xZYvilQxqXfxinRUuKPJMVrrOXo33P5Y7PXZiNRiMldtAyD3gQpcPWY68HrTZWspypX6oLRKRIlRC7Nj4/E6Bwn+pD/TqnN8UwL5SuDm+kp7z/zHXYGfmalIzibOHpPlmV39PcObdPE02wtrxV3WtmZjakzD8vZwnRjwcS3jbcHgwmEnzcAcMrrXtJ4A5G5OlgE7A3U5cCttxd3Y8w3u9meZWAxsb9AzrWGwYUsH1bbStVQqXFZHH5U9VIs8iyQSfHCdV2jEN46nZkwbNVPnIMzQ3eaZrZ4JRth1BUdpNnbvv2mZH7YPbdLz2vWSrBpFfubwuxJHrrEQIDAQABo4IBVDCCAVAwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQU3UDcH284PfxY0A2gvZ7CGfclywIwHwYDVR0jBBgwFoAUiw+PJ4DSk9dGXZGEuy6YYq4E8dIwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjB9BgNVHREEdjB0gg9sb2dpbi5hYWllZHUuaHKGYWh0dHBzOi8vcmVnaXN0cnkuZWR1Z2Fpbi5vcmcvcmVzb2x2ZXI/dXJuPXVybjpnZWFudDplZHVnYWluOmNvbXBvbmVudDpiZTphYWllZHVocjpsb2dpbi5hYWllZHUuaHIwNQYDVR0fBC4wLDAqoCigJoYkaHR0cDovL3NjYS5lZHVnYWluLm9yZy9jcmwvY2FjcmwuZGVyMBsGA1UdIAQUMBIwEAYOKwYBBAGB1H4BDAIAAAQwDQYJKoZIhvcNAQEFBQADggEBAHvccCTPvtBVhBUJA8TZEAhOhctLbafP9vE2BDEuPy7cQLujli9mnocpIthwZ4JmRp2xZeTki+vetpikyc192o4d6iUrYVorY//uow3YUifsSDIN2VNfZvjs0lDAzfdTfXMvDugg8hEoEhOhr/yP6FGalM1nhvxauD4jwv6rgTuKPcNWDvFV6LVCxO0m3Mfk5pSlndFE9SXrQFC1dyXRcU1KqvMjjbZ0idKEpe7wMwIgWNGadqKCtBzF1GLkZQSsgiQUIVD3YG6OYBHzi6+/Shl3oueoMGWa8NQdycPHiz0qBS3CuCVwpJAoGymxJqoyWVkyKcrsYpwFgNq0PoAhN78=',
	'NameIDFormat' => 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient',
);

$metadata['fed-lab.aaiedu.hr'] = array (
        'metadata-set' => 'saml20-idp-remote',
        'entityid' => 'fed-lab.aaiedu.hr',
        'SingleSignOnService' => array (
                0 => array (
                        'Binding' => 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect',
                        'Location' => 'https://fed-lab.aaiedu.hr/sso/saml2/idp/SSOService.php',
                ),
        ),
        'SingleLogoutService' => 'https://fed-lab.aaiedu.hr/sso/saml2/idp/SingleLogoutService.php',
        'certData' => 'MIIEmTCCA4GgAwIBAgIQDY6Ff0PHvxrBTNz0pHhFdDANBgkqhkiG9w0BAQUFADA2MQswCQYDVQQGEwJOTDEPMA0GA1UEChMGVEVSRU5BMRYwFAYDVQQDEw1URVJFTkEgU1NMIENBMB4XDTEyMTIyMjAwMDAwMFoXDTE1MTIyMjIzNTk1OVowaTELMAkGA1UEBhMCSFIxDzANBgNVBAcTBlphZ3JlYjEfMB0GA1UEChMWTVpPUyAtIEFBSUVkdSwgRWR1cm9hbTEMMAoGA1UECxMDSVNBMRowGAYDVQQDExFmZWQtbGFiLmFhaWVkdS5ocjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM1X1luhdeRtHQF9E9401FRpuxF1xaMLeahsiyDnjFHXdbdRaYlO4EQHZ8Q/GmD7YB6ohD5YPcKjiIg8tRn7GwiNu6xEyekwNir0i2/GuWXpGILUyGo3a4GUhWf7pJXT33lV5UpIG08yNbuvrv6psRLrzqU9M0/8v5QeyJFK9mG8BIdzlVd6AKUMVflL9PIzes9ciimHzz+FiVguopyh5NpEziHE3SDw8YriTfXE9Z0fyEczj7tLqFrZJdWTeFb0bg2KXoFZYZX91ld0p8AxFwn12FudsXId+3+VBhfFysF3oMg3pH0Lku5oyucQEcNz9o4VtFpqRXLMBotxNQz7+ysCAwEAAaOCAW4wggFqMB8GA1UdIwQYMBaAFAy9k2gM896ro0lrKzdXR+qQ47ntMB0GA1UdDgQWBBT1G5Gk1cezzlrbc4XYY88m1PR8sDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwIgYDVR0gBBswGTANBgsrBgEEAbIxAQICHTAIBgZngQwBAgIwOgYDVR0fBDMwMTAvoC2gK4YpaHR0cDovL2NybC50Y3MudGVyZW5hLm9yZy9URVJFTkFTU0xDQS5jcmwwbQYIKwYBBQUHAQEEYTBfMDUGCCsGAQUFBzAChilodHRwOi8vY3J0LnRjcy50ZXJlbmEub3JnL1RFUkVOQVNTTENBLmNydDAmBggrBgEFBQcwAYYaaHR0cDovL29jc3AudGNzLnRlcmVuYS5vcmcwHAYDVR0RBBUwE4IRZmVkLWxhYi5hYWllZHUuaHIwDQYJKoZIhvcNAQEFBQADggEBAAxAwmv80jiGPtNV4Y32CVNkHzKfpG23ThJnHkExyn2551pCEaKzXYhot5GUhthJ5dJf1lgFgb53KZkgqOtUuhST/mQJluCyM8npw5UclZNwKlvyViTGaN1/KeByUXnbGjkerwQ7a4udXlS1/wHAWql41gWnGAEM34dx+Kfl0Hax/iUUYD7HdWUoCmgS60IaqHz7vY6oOzSp35ynNPjkwxauh0ttOvsrpSScZBSnqYebTV/VWAaiTf0zp/Nphuik4Q5PbMrFA1zGMNuQlO1zZuur456gF8bVv0YPulcBsnLIoQNzeFbE+eRpdTFLPnXVYJGFZtk2hNSD/b/x0h/yMFo=',
        'NameIDFormat' => 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient',
);

?>
