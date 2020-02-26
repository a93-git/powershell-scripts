# Get the AD user details for all the users and export the data to a csv file


Get-ADUser -Filter * | Select-Object SamAccountName | Out-File ".\users.txt"
Get-Content ".\users.txt" | ForEach-Object -Process {$_.Replace(' ', '')} | Out-File ".\users2.txt"
Get-Content -Path ".\users2.txt" | 
    ForEach-Object -Process { Get-ADUser $_ -Properties SamAccountName,UserPrincipalName, DisplayName, Enabled, PasswordExpired, DistinguishedName, AccountLockoutTime, AccountExpirationDate, BadLogonCount, badPasswordTime, badPwdCount, CannotChangePassword, CanonicalName, Deleted, DoesNotRequirePreAuth, EmailAddress, isDeleted, LastBadPasswordAttempt, lastLogoff, lastLogon, LastLogonDate, lastLogonTimestamp, LockedOut, lockoutTime, logonCount, LogonWorkstations, PasswordLastSet, PasswordNeverExpires, PasswordNotRequired, ProtectedFromAccidentalDeletion, SID, pwdLastSet, TrustedForDelegation, TrustedToAuthForDelegation} | 
    Select-Object SamAccountName,UserPrincipalName, DisplayName, Enabled, PasswordExpired, DistinguishedName, AccountLockoutTime, AccountExpirationDate, BadLogonCount, badPasswordTime, badPwdCount, CannotChangePassword, CanonicalName, Deleted, DoesNotRequirePreAuth, EmailAddress, isDeleted, LastBadPasswordAttempt, lastLogoff, lastLogon, LastLogonDate, lastLogonTimestamp, LockedOut, lockoutTime, logonCount, LogonWorkstations, PasswordLastSet, PasswordNeverExpires, PasswordNotRequired, ProtectedFromAccidentalDeletion, SID, pwdLastSet, TrustedForDelegation, TrustedToAuthForDelegation | 
    Export-Csv -Path ".\ADAudit.csv" -NoTypeInformation