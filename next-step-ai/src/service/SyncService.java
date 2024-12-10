package com.nextstep.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.nextstep.repository.PredictionRepository;
import com.nextstep.model.*;
import java.util.*;

@Service
public class SyncService {
    
    @Autowired
    private PredictionRepository predictionRepository;
    
    @Autowired
    private MLService mlService;
    
    public SyncResponse pullChanges(long lastSyncTimestamp, String deviceId) {
        // Get all changes since last sync
        List<Prediction> changes = predictionRepository.findChangesSince(lastSyncTimestamp);
        
        // Process changes through ML model if needed
        changes.stream()
            .filter(p -> p.needsPrediction())
            .forEach(p -> {
                PredictionResult result = mlService.predict(p.getData());
                p.setPrediction(result);
                predictionRepository.save(p);
            });
            
        return new SyncResponse(changes, System.currentTimeMillis());
    }
    
    public SyncResponse pushChanges(List<Change> changes, String deviceId) {
        // Validate and merge changes
        List<Prediction> mergedChanges = new ArrayList<>();
        for (Change change : changes) {
            if (isValidChange(change)) {
                Prediction prediction = predictionRepository.findById(change.getId())
                    .orElse(new Prediction());
                prediction.merge(change);
                
                // Run through ML model if needed
                if (prediction.needsPrediction()) {
                    PredictionResult result = mlService.predict(prediction.getData());
                    prediction.setPrediction(result);
                }
                
                mergedChanges.add(predictionRepository.save(prediction));
            }
        }
        
        return new SyncResponse(mergedChanges, System.currentTimeMillis());
    }
    
    public SyncStatus getSyncStatus(String deviceId) {
        DeviceSync deviceSync = deviceSyncRepository.findByDeviceId(deviceId)
            .orElse(new DeviceSync(deviceId));
        return new SyncStatus(
            deviceSync.getLastSyncTimestamp(),
            deviceSync.getPendingChangesCount()
        );
    }
    
    private boolean isValidChange(Change change) {
        // Implement validation logic
        return true;
    }
}
