import { useState } from 'react';
import Camera from './Camera';
import './App.css';

function App() {
  const [photos, setPhotos] = useState<string[]>([]);

  const handlePhotoTaken = (photoData: string) => {
    setPhotos(prev => [photoData, ...prev]);
  };

  return (
    <div className="app">
      <Camera onPhotoTaken={handlePhotoTaken} />

      {photos.length > 0 && (
        <div className="photo-gallery">
          <h2>Recent Photos</h2>
          <div className="photo-grid">
            {photos.slice(0, 6).map((photo, index) => (
              <img
                key={index}
                src={photo}
                alt={`Photo ${index + 1}`}
                className="photo-thumbnail"
              />
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
