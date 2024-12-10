package com.nextstep.api;

import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import com.nextstep.service.SyncService;
import com.nextstep.model.SyncRequest;
import com.nextstep.model.SyncResponse;

@RestController
@RequestMapping("/api/sync")
public class SyncController {
    
    @Autowired
    private SyncService syncService;
    
    @PostMapping("/pull")
    public SyncResponse pullChanges(@RequestBody SyncRequest request) {
        return syncService.pullChanges(request.getLastSyncTimestamp(), request.getDeviceId());
    }
    
    @PostMapping("/push")
    public SyncResponse pushChanges(@RequestBody SyncRequest request) {
        return syncService.pushChanges(request.getChanges(), request.getDeviceId());
    }
    
    @GetMapping("/status")
    public SyncStatus checkSyncStatus(@RequestParam String deviceId) {
        return syncService.getSyncStatus(deviceId);
    }
}
