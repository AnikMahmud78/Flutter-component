describe('10269GEN-02039 Automated Visual Regression Grid Test Suite', () => {
  const testData = require('../fixtures/grid_test_data.json');

  testData.viewports.forEach((vp: { width: number; height: number; name: string }) => {
    it(`Should fail PR build if components overflow assigned columns on \${vp.name} viewport`, () => {
      cy.viewport(vp.width, vp.height);
      cy.visit('/console/layout-test');

      cy.get('.habot-grid-container').then((\$container) => {
        const containerRect = \$container[0].getBoundingClientRect();
        
        cy.get('.habot-card-component').each((\$card) => {
          const cardRect = \$card[0].getBoundingClientRect();
          
          // Strictly fail test if right edge breaks out of parent container
          expect(cardRect.right).to.be.at.most(
            containerRect.right + 0.5,
            `Visual Regression Alert: Component broke out of assigned grid column on \${vp.name}`
          );
        });
      });
    });
  });
});
