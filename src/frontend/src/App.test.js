import {render, screen} from '@testing-library/react';
import App from './App';

test('renders get joke button', () => {
  render(<App />);
  const linkElement = screen.getByText(/GET JOKE/i);
  expect(linkElement).toBeInTheDocument();
});
