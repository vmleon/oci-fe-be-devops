import React, {useEffect, useState} from 'react';
import LoadingButton from '@mui/lab/LoadingButton';
import CelebrationIcon from '@mui/icons-material/Celebration';
import Alert from '@mui/material/Alert';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import './App.css';

function App() {
  const [text, setText] = useState('Loading...');
  const [isLoading, setLoading] = useState(false);
  const [error, setError] = useState();

  const getNewJoke = async () => {
    setLoading(true);
    try {
      const response = await fetch('/joke');
      const body = await response.json();
      setText(body.joke);
      setError(null);
    } catch (error) {
      setError(error.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    console.log('effect');
    getNewJoke();
  }, []);

  const clickGetNewJoke = () => {
    getNewJoke();
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
        onClick={() => clickGetNewJoke()}
      >
        Get Joke
      </LoadingButton>
      <Box sx={{width: '100%', maxWidth: 500, paddingTop: '1rem'}}>
        <Typography variant="body1" gutterBottom>
          {text}
        </Typography>
      </Box>
      {error && <Alert severity="error">{error}</Alert>}
    </div>
  );
}

export default App;
