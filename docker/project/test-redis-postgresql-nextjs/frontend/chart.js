import React from 'react';
import { Line } from 'react-chartjs-2';

function LineGraph({ data }) {
  // Extract and format data for the line graph
  // ...

  const chartData = {
    labels: /* Data labels */,
    datasets: /* Data datasets */,
  };

  return (
    <div>
      <Line data={chartData} />
    </div>
  );
}

export default LineGraph;