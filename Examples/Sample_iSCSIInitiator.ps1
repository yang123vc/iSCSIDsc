configuration Sample_iSCSIInitiator
{
    Param
    (
         [String] $NodeName = 'LocalHost'
    )

    Import-DscResource -Module iSCSIDSc

    Node $NodeName
    {
        Service iSCSIService
        {
            Name = 'MSiSCSI'
            StartupType = 'Automatic'
            State = 'Running'
        }

        iSCSIInitiator iSCSIInitiator
        {
            Ensure = 'Present'
            NodeAddress = 'iqn.1991-05.com.microsoft:fileserver01-cluster-target'
            TargetPortalAddress = '192.168.128.10'
            InitiatorPortalAddress = '192.168.128.20'
            IsPersistent = $true
            iSNSServer = 'isns.contoso.com'
            DependsOn = "[Service]iSCSIService"
        } # End of iSCSIInitiator Resource
    } # End of Node
} # End of Configuration
