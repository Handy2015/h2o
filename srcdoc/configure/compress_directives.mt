? my $ctx = $main::context;
? $_mt->wrapper_file("wrapper.mt", "Configure", "Compress Directives")->(sub {

<p>
The compress handler performs on-the-fly compression - it compresses the contents of an HTTP response as it is being sent, if all of the following conditions are met:
<ul>
<li>client indicates itself to be capable of decompressing the response transparently with the use of <a href="https://tools.ietf.org/html/rfc7231#section-5.3.4"><code>Accept-Encoding</code></a> header</li>
<li>the response is deemed compressible (by checking the content-type, see <a href="configure/file_directives.html#file.mime.addtypes"><code>file.mime.addtypes</code></a>)</li>
</ul>
</ul>
</p>
<p>
The following are the  configuration directives recognized by the handler.
</p>

<?
$ctx->{directive}->(
    name     => "compress",
    levels   => [ qw(global host path extension) ],
    default  => "compress: OFF",
    see_also => render_mt(<<'EOT'),
<a href="configure/file_directives.html#file.send-compressed"><code>file.send-compressed</code></a>, <a href="configure/file_directives.html#file.mime.addtypes"><code>file.mime.addtypes</code></a>
EOT
    since    => '2.0',
    desc     => <<'EOT',
Enables on-the-fly compression of HTTP response.
EOT
)->(sub {
?>
<p>
If the argument is <code>ON</code>, both <a href="https://datatracker.ietf.org/doc/draft-alakuijala-brotli/">brotli</a> and <a href="https://tools.ietf.org/html/rfc1952">gzip</a> compression are enabled.
If the argument is <code>OFF</code>, on-the-fly compression is disabled.
If the argument is a sequence, the elements are the list of compression algorithms to be enabled.
If the argument is a mapping, each key specifies the compression algorithm to be enabled, and the values specify the quality of the algorithms.
</p>
<p>
When both brotli and gzip are enabled and if the client supports both, H2O is hard-coded to prefer brotli.
</p>
<?= $ctx->{example}->('Enabling on-the-fly compression', <<'EOT')
# enable all algorithms
compress: ON

# enable by name
compress: [ gzip, brotli ]

# enable gzip only
compress: [ gzip ]
EOT
?>
? })

<?
$ctx->{directive}->(
    name     => "gzip",
    levels   => [ qw(global host path extension) ],
    default  => "gzip: OFF",
    see_also => render_mt(<<'EOT'),
<a href="configure/compress_directives.html#compress"><code>compress</code></a>
EOT
    since    => '1.5',
    desc     => <<'EOT',
Enables on-the-fly compression of HTTP response using gzip.
EOT
)->(sub {
?>
Equivalent to <code>compress: [ gzip ]</code>.
? })

? })
