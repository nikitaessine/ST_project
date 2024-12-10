import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  vus:1000,  
  iterations: 1000,
};

export default function () {
  // Make a GET request to the target URL
  const res = http.get('http://localhost/register');

  // Check if the response status is 200
  const success = check(res, {
    'status is 200': (res) => res.status === 200,
  });

  // Log the status code
  console.log(`Response status: ${res.status}, Success: ${success}`);

  // Sleep for 1 second to simulate real-world usage
  sleep(1);
}