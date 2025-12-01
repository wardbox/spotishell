@{
    # PSScriptAnalyzer settings for Spotishell
    # https://github.com/PowerShell/PSScriptAnalyzer
    #
    # Note: Many rules are excluded due to pre-existing code patterns.
    # TODO: Address these in a dedicated code quality improvement PR

    Severity = @('Error', 'Warning')

    ExcludeRules = @(
        # Existing function names use plural nouns (Get-PlaylistItems, etc.)
        # Changing would break backward compatibility
        'PSUseSingularNouns'

        # ShouldProcess support requires significant refactoring
        'PSUseShouldProcessForStateChangingFunctions'

        # Write-Host is used intentionally for user feedback during OAuth flow
        'PSAvoidUsingWriteHost'

        # Pipeline commands use ForEach instead of process blocks (existing pattern)
        'PSUseProcessBlockForPipelineCommand'

        # Manifest uses wildcards for exports (working as intended)
        'PSUseToExportFieldsInManifest'

        # Some files don't have BOM (not causing issues)
        'PSUseBOMForUnicodeEncodedFile'

        # False positives on parameters used in child scopes
        'PSReviewUnusedParameter'
    )
}
