package com.yanma408.workbench.application.material;

import java.util.List;

public record MaterialScanResult(
        String rootPath,
        int scannedFiles,
        int registeredFiles,
        int skippedFiles,
        List<MaterialAsset> assets
) {
}
