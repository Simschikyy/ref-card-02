import { render, screen } from '@testing-library/react';
import App from './App';

test('renders the app title', () => {
  render(<App />);
  expect(screen.getByText('App Ref. Card 02')).toBeInTheDocument();
});

test('renders the status message', () => {
  render(<App />);
  expect(screen.getByText(/up and running/i)).toBeInTheDocument();
});
