# Set-InstalledFlag — Documentation

## Overview

`Set-InstalledFlag` is a PowerShell function that writes a custom registry-based detection flag. It's designed to be embedded inside a larger **install script**, where it marks a registry key/value at the end of a successful installation — giving deployment tools (e.g., Intune, SCCM) a reliable custom detection rule to confirm the application installed correctly.

| Field | Value |
|---|---|
| **Author** | Nic Lindstrom |
| **Purpose** | Set a custom registry detection flag for use inside an install script |
| **Type** | Function (intended to be embedded in a parent script, not run standalone) |

---

## How It Works

1. **Parameters** — `InstalledKey` (registry path) and `Value` (the value to write to `Installed`) are declared as mandatory parameters.
2. **Manual override block** — Directly below the parameters, `$InstalledKey` and `$Value` are hardcoded. This block is meant for manually setting the flag details when embedding the function into an install script.
   > **Note:** Because these lines run immediately after `param()`, they overwrite any values passed in as parameters.
3. **`try` block** — Attempts to read the registry key with `Get-ChildItem`. `-ErrorAction Stop` forces a terminating error if the key doesn't exist, triggering the `catch` block.
   - If the key **exists**, `Installed` is set to `$Value`.
4. **`catch` block** — If the key doesn't exist, `New-Item` creates it, then `Installed` is set to `$Value` the same way.

**Net result:** After the function runs, the specified registry key exists and its `Installed` value is set — usable as a custom detection rule in the parent install script.

---

## Usage (Embedded in an Install Script)

```powershell
# ... install logic above ...

Set-InstalledFlag

# ... continue install script ...
```

Since `InstalledKey` and `Value` are hardcoded inside the function body, no arguments need to be passed when calling it — just update the hardcoded values inside the function to match the target application before embedding.

---

## Known Limitations

| Issue | Detail |
|---|---|
| Hardcoded values override parameters | `$InstalledKey` and `$Value` are reassigned right after `param()`, so passed-in parameter values are ignored |
| Inconsistent path syntax | `Get-ChildItem`/`New-Item` use the raw path; `Set-ItemProperty` uses the `Registry::` provider prefix |
| No `-Force` on `New-Item` | If parent keys in the path don't exist, key creation will fail without `-Force` |
| No uninstall logic | Function only ever sets the flag; no logic to remove/reset it on uninstall |
| No logging | No audit trail of when/whether the flag was set |

---
