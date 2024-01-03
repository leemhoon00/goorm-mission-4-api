import { Test, TestingModule } from '@nestjs/testing';
import { UsersController } from '../users.controller';
import { UsersService } from '../users.service';

describe('UsersController', () => {
  let controller: UsersController;
  let userService: UsersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UsersController],
      providers: [
        {
          provide: UsersService,
          useValue: {
            insertOne: jest.fn(),
            findAll: jest.fn(),
          },
        },
      ],
    }).compile();

    controller = module.get<UsersController>(UsersController);
    userService = module.get<UsersService>(UsersService);
  });

  describe('createOne', () => {
    it('should call userService.insertOne', () => {
      const data = { name: 'John Doe' };
      controller.createOne(data);
      expect(userService.insertOne).toHaveBeenCalledWith(data);
    });
  });

  describe('findAll', () => {
    it('should call userService.findAll', () => {
      controller.findAll();
      expect(userService.findAll).toHaveBeenCalled();
    });
  });
});
