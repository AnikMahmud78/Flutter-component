// Location: tests/e2e/MobileLayoutResponsiveCheck.spec.ts
/// <reference types="cypress" />

describe('Task 14240AEETE-021: Standardized Cypress Front-End Interface Validation', () => {
  beforeEach(() => {
    // Set viewport to standard 360px mobile baseline display
    cy.viewport(360, 740);
    cy.visit('/');
  });

  it('1. Verifies 360px display layout responsiveness and zero overflow', () => {
    cy.get('[data-cy="mobile-container"]')
      .should('be.visible')
      .should('have.css', 'width', '360px');

    // Ensure horizontal scrolling is prevented
    cy.window().then((win) => {
      expect(win.document.documentElement.scrollWidth).to.equal(360);
    });
  });

  it('2. Programmatically tracks touch target dimensions (>= 48x48dp)', () => {
    cy.get('button, [role="button"], a').each(($el) => {
      const rect = $el[0].getBoundingClientRect();
      expect(rect.width).to.be.at.least(48);
      expect(rect.height).to.be.at.least(48);
    });
  });

  it('3. Validates form focus loops move cleanly without skipping fields', () => {
    cy.get('[data-cy="input_username"]').focus().should('have.focus');
    cy.get('[data-cy="input_username"]').tab().should('have.focus');
    cy.get('[data-cy="input_email"]').should('have.focus');
  });

  it('4. Ensures modal dialog windows lock body layer scrolling', () => {
    cy.get('[data-cy="open-modal-btn"]').click();
    cy.get('[data-cy="modal-dialog"]').should('be.visible');
    cy.get('body').should('have.css', 'overflow', 'hidden');
    cy.get('[data-cy="close-modal-btn"]').click();
    cy.get('body').should('not.have.css', 'overflow', 'hidden');
  });
});
