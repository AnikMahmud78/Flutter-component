declare namespace Cypress {
  interface Chainable {
    checkColumnBoundary(selector: string, maxAllowedRightMargin: number): Chainable<void>;
  }
}

Cypress.Commands.add('checkColumnBoundary', (selector: string, maxAllowedRightMargin: number) => {
  cy.get(selector).then((\$el) => {
    const rect = \$el[0].getBoundingClientRect();
    expect(rect.right).to.be.at.most(maxAllowedRightMargin, `Element \${selector} breaks out of assigned column boundary!`);
  });
});
