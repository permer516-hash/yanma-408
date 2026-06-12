package com.yanma408.workbench.application.material;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface MaterialAssetRepository {
    MaterialAsset save(MaterialAsset asset);

    MaterialAsset saveIfAbsent(MaterialAsset asset);

    List<MaterialAsset> search(MaterialAssetSearchFilter filter);

    Optional<MaterialAsset> findById(UUID id);

    Optional<MaterialAsset> findByBucketAndObjectKey(String bucket, String objectKey);
}
