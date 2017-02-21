import { ValuconFrontendPage } from './app.po';

describe('valucon-frontend App', function() {
  let page: ValuconFrontendPage;

  beforeEach(() => {
    page = new ValuconFrontendPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
