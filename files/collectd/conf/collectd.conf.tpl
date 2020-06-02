Hostname "{{ MY_NAME }}"

FQDNLookup false

TypesDB "/usr/share/collectd/types.db"

AutoLoadPlugin false

CollectInternalStats true

Interval 60

#MaxReadInterval 86400
#Timeout         2
#ReadThreads     5
#WriteThreads    5

WriteQueueLimitHigh 1000000
WriteQueueLimitLow   800000



LoadPlugin log_logstash

<Plugin log_logstash>
    LogLevel warn
    File "/var/log/collectd.json.log"
</Plugin>



<Include "/etc/collectd/collectd.conf.d">
    Filter "*.conf"
</Include>



LoadPlugin unixsock
<Plugin unixsock>
    SocketFile "/var/run/collectd-unixsock"
    SocketGroup "collectd"
    SocketPerms "0660"
    DeleteSocket false
</Plugin>



LoadPlugin write_graphite
<Plugin write_graphite>
    <Node "local-graphite-relay">
        Host "graphite-collectd"
        Port "2003"
        Protocol "{{ COLLECTD_GRAPHITE_PROTOCOL }}"
        LogSendErrors true
        Prefix "collectd."
        StoreRates true
        AlwaysAppendDS false
        ReconnectInterval 120
        EscapeCharacter "_"
        PreserveSeparator true 
    </Node>
</Plugin>
