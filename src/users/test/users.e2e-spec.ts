import { Test, TestingModule } from '@nestjs/testing';
import { UsersController } from '../users.controller';
import { UsersService } from '../users.service';
import { PrismaService } from '../prisma.service';

describe('UsersController', () => {
  let controller: UsersController;
  let prisma: PrismaService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UsersController],
      providers: [UsersService, PrismaService],
    }).compile();

    controller = module.get<UsersController>(UsersController);
    prisma = module.get<PrismaService>(PrismaService);
  });

  describe('createOne', () => {
    it('insert a user', async () => {
      // given
      const userName = 'test user2';

      // when
      await controller.createOne({ name: userName });

      // then
      const user = await prisma.user.findFirst({
        where: { name: userName },
      });
      expect(user).toHaveProperty('name', userName);

      // cleanup
      await prisma.user.deleteMany({
        where: { name: userName },
      });
    });
  });

  describe('findAll', () => {
    it('return all users', async () => {
      // given
      await prisma.user.createMany({
        data: [{ name: 'test user3' }, { name: 'test user4' }],
      });

      // when
      const users = await controller.findAll();

      // then
      expect(users.length).toBeGreaterThan(1);

      // cleanup
      await prisma.user.deleteMany({
        where: {
          name: {
            in: ['test user3', 'test user4'],
          },
        },
      });
    });
  });
});
