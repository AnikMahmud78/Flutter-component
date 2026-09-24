import * as fs from 'fs';

export interface LinterReport {
  filesScanned: number;
  violationsFound: number;
  passRate: number;
  status: 'PASS' | 'FAIL';
}

// English Code (EC): Run-Design-Token-Linter-Guard
export function runDesignTokenLinterGuard(codeSnippets: string[]): LinterReport {
  const rawColorRegex = /#(?:[0-9a-fA-F]{3}){1,2}\b|rgb\([^)]+\)/g;
  let totalViolations = 0;

  codeSnippets.forEach(snippet => {
    const matches = snippet.match(rawColorRegex);
    if (matches) {
      totalViolations += matches.length;
    }
  });

  const passRate = codeSnippets.length > 0 ? ((codeSnippets.length - totalViolations) / codeSnippets.length) * 100 : 100;

  return {
    filesScanned: codeSnippets.length,
    violationsFound: totalViolations,
    passRate: Math.max(0, passRate),
    status: totalViolations === 0 ? 'PASS' : 'FAIL',
  };
}

// Dry run execution
const testSnippets = [
  "color: var(--md-sys-color-primary)",
  "padding: var(--md-sys-spacing-md)",
];
console.log(runDesignTokenLinterGuard(testSnippets));
