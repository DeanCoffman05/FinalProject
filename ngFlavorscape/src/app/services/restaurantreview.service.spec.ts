import { TestBed } from '@angular/core/testing';

import { RestaurantreviewService } from './restaurantreview.service';

describe('RestaurantreviewService', () => {
  let service: RestaurantreviewService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(RestaurantreviewService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
