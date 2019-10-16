“Schema Admins”, “Domain Admins”, “Enterprise Admins” |

foreach {

 $grpname = $_

 Get-ADGroupMember -Identity $_ |

 select @{N=’Group’; E={$grpname}}, Name

}