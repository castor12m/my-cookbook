import React, { useState, useEffect } from 'react';
import axios from 'axios';
import LineGraph from './LineGraph'; // Your LineGraph component

function App() {
  const [data, setData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const response = await axios.get('/get_latest_data');
      setData(response.data);
    };
    fetchData();
  }, []);

  return (
    <div>
      <h1>Data Values Line Graph</h1>
      <LineGraph data={data} />
    </div>
  );
}

export default App;