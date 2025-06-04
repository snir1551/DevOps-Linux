import { describe, it, expect } from 'vitest';
import { sum, subtract } from './math.js';

describe('Math functions', () => {
  it('adds two numbers', () => {
    expect(sum(2, 3)).toBe(5);
  });

  it('subtracts two numbers', () => {
    expect(subtract(5, 2)).toBe(3);
  });
});