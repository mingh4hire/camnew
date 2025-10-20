import { useRef, useEffect, useState, useCallback } from 'react';
import './Camera.css';

interface CameraProps {
  onPhotoTaken?: (photoData: string) => void;
}

const Camera: React.FC<CameraProps> = ({ onPhotoTaken }) => {
  const videoRef = useRef<HTMLVideoElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const streamRef = useRef<MediaStream | null>(null);
  const [isStreaming, setIsStreaming] = useState(false);
  const [zoom, setZoom] = useState(1);
  const [error, setError] = useState<string | null>(null);

  const startCamera = useCallback(async () => {
    try {
      setError(null);
      const stream = await navigator.mediaDevices.getUserMedia({
        video: {
          facingMode: 'user',
          width: { ideal: 1920 },
          height: { ideal: 1080 }
        }
      });

      if (videoRef.current) {
        videoRef.current.srcObject = stream;
        streamRef.current = stream;
        setIsStreaming(true);
      }
    } catch (err) {
      setError('Unable to access camera. Please check permissions.');
      console.error('Error accessing camera:', err);
    }
  }, []);

  const stopCamera = useCallback(() => {
    if (streamRef.current) {
      streamRef.current.getTracks().forEach(track => track.stop());
      streamRef.current = null;
    }
    setIsStreaming(false);
  }, []);

  const takePhoto = useCallback(() => {
    if (!videoRef.current || !canvasRef.current || !isStreaming) return;

    const video = videoRef.current;
    const canvas = canvasRef.current;
    const context = canvas.getContext('2d');

    if (!context) return;

    // Set canvas size to match video
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    // Apply zoom transform
    context.save();
    context.scale(zoom, zoom);
    context.translate(-video.videoWidth * (zoom - 1) / (2 * zoom), -video.videoHeight * (zoom - 1) / (2 * zoom));

    // Draw the video frame to canvas
    context.drawImage(video, 0, 0, video.videoWidth, video.videoHeight);
    context.restore();

    // Get the photo data
    const photoData = canvas.toDataURL('image/jpeg', 0.9);

    // Call the callback if provided
    if (onPhotoTaken) {
      onPhotoTaken(photoData);
    }

    // Download the photo
    const link = document.createElement('a');
    link.download = `photo-${new Date().toISOString().slice(0, 19).replace(/:/g, '-')}.jpg`;
    link.href = photoData;
    link.click();
  }, [isStreaming, zoom, onPhotoTaken]);

  const zoomIn = useCallback(() => {
    setZoom(prev => Math.min(prev + 0.1, 3));
  }, []);

  const zoomOut = useCallback(() => {
    setZoom(prev => Math.max(prev - 0.1, 0.5));
  }, []);

  useEffect(() => {
    startCamera();

    return () => {
      stopCamera();
    };
  }, [startCamera, stopCamera]);

  return (
    <div className="camera-container">
      <div className="camera-view">
        <video
          ref={videoRef}
          autoPlay
          playsInline
          muted
          className="camera-video"
          style={{ transform: `scale(${zoom})` }}
        />
        <canvas ref={canvasRef} style={{ display: 'none' }} />
      </div>

      {error && (
        <div className="camera-error">
          <p>{error}</p>
          <button onClick={startCamera}>Try Again</button>
        </div>
      )}

      <div className="camera-controls">
        <button
          className="control-btn zoom-out"
          onClick={zoomOut}
          disabled={zoom <= 0.5}
        >
          🔍-
        </button>

        <button
          className="control-btn capture"
          onClick={takePhoto}
          disabled={!isStreaming}
        >
          📸 Take Photo
        </button>

        <button
          className="control-btn zoom-in"
          onClick={zoomIn}
          disabled={zoom >= 3}
        >
          🔍+
        </button>
      </div>

      <div className="camera-info">
        <p>Zoom: {zoom.toFixed(1)}x</p>
        {isStreaming && <p>Camera active</p>}
      </div>
    </div>
  );
};

export default Camera;