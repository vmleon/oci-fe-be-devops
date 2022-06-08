import {render, screen} from '@testing-library/react';
import App from './App';

test('renders get time button', () => {
  render(<App />);
  const linkElement = screen.getByText(/GET TIME/i);
  expect(linkElement).toBeInTheDocument();
});
