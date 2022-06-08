import React, {useEffect, useState} from 'react';
import LoadingButton from '@mui/lab/LoadingButton';
import CelebrationIcon from '@mui/icons-material/Celebration';
import Alert from '@mui/material/Alert';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import './App.css';

function App() {
  const [time, setTime] = useState('Loading...');
  const [isLoading, setLoading] = useState(false);
  const [error, setError] = useState();

  const getNewTime = async () => {
    setLoading(true);
    try {
      const response = await fetch('/database');
      const body = await response.json();
      setTime(body.time);
      setError(null);
    } catch (error) {
      setError(error.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    console.log('effect');
    getNewTime();
  }, []);

  const clickGetNewTime = () => {
    getNewTime();
  };

  return (
    <div className="App">
      <Typography variant="h1" component="div" gutterBottom>
        Frontend
      </Typography>
      <LoadingButton
        loading={isLoading}
        loadingPosition="start"
        startIcon={<CelebrationIcon />}
        variant="contained"
        onClick={() => clickGetNewTime()}
      >
        Get Time
      </LoadingButton>
      <Box sx={{width: '100%', maxWidth: 500, paddingTop: '1rem'}}>
        <Typography variant="body1" gutterBottom>
          {time}
        </Typography>
      </Box>
      {error && <Alert severity="error">{error}</Alert>}
    </div>
  );
}

export default App;
